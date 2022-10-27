//
//  ModalPresenter.swift
//  ShortcutFoundation
//
//  Created by Darya Gurinovich on 2022-01-07.
//  Copyright © 2022 Shortcut Scandinavia Apps AB. All rights reserved.
//

import Foundation
import SwiftUI

/// A protocol describing all modals that can be shown
///
/// An example of the ModalPresentationState implementaion
/// ```
/// enum ModalViewPresentationState: ModalPresentationState {
///     case error(String)
///
///     var id: String {
///         switch self {
///         case .error(let description):
///             return "error-\(description)"
///         }
///     }
///
///     func view(dismissAction: @escaping () -> Void) -> some View {
///         switch self {
///         case .error(let description):
///             return Text(description)
///         }
///     }
/// }
/// ```
public protocol ModalPresentationState: Identifiable, Equatable {
    associatedtype Content: View

    @ViewBuilder func view(dismissAction: @escaping () -> Void) -> Content
}

public enum ModalPresentationType {
    case customSheet
    case fullscreen
    case sheet
}

protocol ModalPresenter {
    associatedtype PresentationState: ModalPresentationState

    func setModal(state: PresentationState, type: ModalPresentationType)
    func setModal(state: PresentationState, type: ModalPresentationType, onDismiss: @escaping() -> Void)
    func closeModal()
}

/// A router to manipulate (show/close) different modal view states (customSheet, fullscreen, sheet). This class should be `open` so it can be inherited
open class ModalViewRouter<PresentationState: ModalPresentationState>: ObservableObject, ModalPresenter {
    @Published var customSheetPresentationState: PresentationState? {
        didSet {
            handlePresentationStateChange(oldValue: oldValue, newValue: customSheetPresentationState)
        }
    }
    @Published var fullScreenModalPresentationState: PresentationState? {
        didSet {
            handlePresentationStateChange(oldValue: oldValue, newValue: fullScreenModalPresentationState)
        }
    }
    @Published var sheetPresentationState: PresentationState? {
        didSet {
            handlePresentationStateChange(oldValue: oldValue, newValue: sheetPresentationState)
        }
    }
    
    private var onDismiss: (() -> Void)?

    public init() {}
    
    // MARK: Modal open/close

    public func setModal(state: PresentationState, type: ModalPresentationType) {
        modal(state: state, type: type, onDismiss: nil)
    }

    public func setModal(state: PresentationState, type: ModalPresentationType, onDismiss: @escaping() -> Void) {
        modal(state: state, type: type, onDismiss: onDismiss)
    }

    public func closeModal() {
        customSheetPresentationState = nil
        fullScreenModalPresentationState = nil
        sheetPresentationState = nil
    }
    
    // MARK: Modal manipulation

    private func modal(state: PresentationState, type: ModalPresentationType, onDismiss: (() -> Void)? = nil) {
        if customSheetPresentationState == nil, fullScreenModalPresentationState == nil, sheetPresentationState == nil {
            self.onDismiss = onDismiss
            
            switch type {
            case .customSheet:
                customSheetPresentationState = state
            case .fullscreen:
                fullScreenModalPresentationState = state
            case .sheet:
                sheetPresentationState = state
            }
        } else {
            closeModal()
            // This delay is fixing an issue where exchanging modals would create an issue where
            // they were presented in the previous views modal window
            DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(300))) {
                self.modal(state: state, type: type, onDismiss: onDismiss ?? nil)
            }
        }
    }
    
    // MARK: Modal close actions

    /// Checks whether the presentation state was updated and removed, calls the dismiss action on true
    ///
    ///  - parameters:
    ///     - oldValue: Old presentation state value
    ///     - newValue: New presentation state value
    ///     
    private func handlePresentationStateChange(oldValue: PresentationState?, newValue: PresentationState?) {
        guard oldValue != newValue, newValue == nil else { return }
        
        dismissOnClose()
    }
    
    /// Calls the dismiss action and removes it
    private func dismissOnClose() {
        onDismiss?()
        
        onDismiss = nil
    }
}
