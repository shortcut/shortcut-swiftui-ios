//
//  AlertPresenter.swift
//  ShortcutSwiftUI
//
//  Created by Sheikh Bayazid on 2022-02-11.
//  Copyright © 2022 Shortcut Scandinavia Apps AB. All rights reserved.
//

import Foundation
import SwiftUI

protocol IAlertPresenter {
    func setAlert(state: AlertPresentationState, type: AlertPresentationType)
    func closeAlert()
}

class AlertPresenter: ObservableObject, IAlertPresenter {
    
    @Published var alertPresentationState: AlertPresentationState?
    @Published var actionSheetPresentationState: AlertPresentationState?
    
    init() {}
    
    func setAlert(state: AlertPresentationState, type: AlertPresentationType) {
        alert(state: state, type: type)
    }
    
    func closeAlert() {
        alertPresentationState = nil
        actionSheetPresentationState = nil
    }
    
    private func alert(state: AlertPresentationState, type: AlertPresentationType) {
        if alertPresentationState == nil, actionSheetPresentationState == nil {
            switch type {
            case .alert:
                alertPresentationState = state
            case .actionSheet:
                actionSheetPresentationState = state
            }
        } else {
            closeAlert()
            self.alert(state: state, type: type)
        }
    }
    
    func alertContent(for state: AlertPresentationState) -> Alert {
        switch state {
            
        case .titleAndDismiss(let title, let buttonTitle):
            return Alert(vm: .init(title: title,
                                   primary: .init(title: buttonTitle, action: { }, buttonType: .cancel)))
            
        case .titleMessageAndDismiss(let title, let message, let buttonTitle, let action):
            return Alert(vm: .init(title: title,
                                   message: message,
                                   primary: .init(title: buttonTitle, action: action, buttonType: .cancel)))
            
        case .titleAndTwoButton(let title, let primaryTitle, let primaryAction, let primaryButtonType, let secondaryTitle, let secondaryAction, let secondaryButtonType):
            return Alert(vm: .init(title: title,
                                   primary: .init(title: primaryTitle, action: primaryAction, buttonType: primaryButtonType),
                                   secondary: .init(title: secondaryTitle, action: secondaryAction, buttonType: secondaryButtonType)))
            
        case .titleMessageAndTwoButton(let title, let message, let primaryTitle, let primaryAction, let primaryButtonType, let secondaryTitle, let secondaryAction, let secondaryButtonType):
            return Alert(vm: .init(title: title,
                                   message: message,
                                   primary: .init(title: primaryTitle, action: primaryAction, buttonType: primaryButtonType),
                                   secondary: .init(title: secondaryTitle, action: secondaryAction, buttonType: secondaryButtonType)))
        }
    }
    
    func actionSheetContent(for state: AlertPresentationState) -> ActionSheet {
        switch state {
            
        case .titleAndDismiss(let title, let buttonTitle):
            return ActionSheet(vm: .init(title: title,
                                         primary: .init(title: buttonTitle, action: {}, buttonType: .cancel)))
            
        case .titleMessageAndDismiss(let title, let message, let buttonTitle, let action):
            return ActionSheet(vm: .init(title: title,
                                         message: message,
                                         primary: .init(title: buttonTitle, action: action, buttonType: .cancel)))
            
        case .titleAndTwoButton(let title, let primaryTitle, let primaryAction, let primaryButtonType, let secondaryTitle, let secondaryAction, let secondaryButtonType):
            return ActionSheet(vm: .init(title: title,
                                         primary: .init(title: primaryTitle, action: primaryAction, buttonType: primaryButtonType),
                                         secondary: .init(title: secondaryTitle, action: secondaryAction, buttonType: secondaryButtonType)))
            
        case .titleMessageAndTwoButton(let title, let message, let primaryTitle, let primaryAction, let primaryButtonType, let secondaryTitle, let secondaryAction, let secondaryButtonType):
            return ActionSheet(vm: .init(title: title,
                                         message: message,
                                         primary: .init(title: primaryTitle, action: primaryAction, buttonType: primaryButtonType),
                                         secondary: .init(title: secondaryTitle, action: secondaryAction, buttonType: secondaryButtonType)))
        }
    }
}

enum AlertPresentationState: Identifiable {
    
    var id: String {
        switch self {
        case .titleAndDismiss: return "titleAndDismiss"
        case .titleMessageAndDismiss: return "titleMessageAndDismiss"
        case .titleAndTwoButton: return "titleAndTwoButton"
        case .titleMessageAndTwoButton: return "titleMessageAndTwoButton"
        }
    }
    
    // alert title, message, action
    case titleAndDismiss(Alert.Title, Alert.DismissButtonTitle)
    case titleMessageAndDismiss(Alert.Title, Alert.Message, Alert.DismissButtonTitle, Alert.DismissButtonAction)
    case titleAndTwoButton(Alert.Title, Alert.PrimaryButtonTitle, Alert.PrimaryButtonAction, AlertViewModel.Action.ButtonType = .normal,
                           Alert.SecondaryButtonTitle, Alert.SecondaryButtonAction, AlertViewModel.Action.ButtonType = .cancel)
    case titleMessageAndTwoButton(Alert.Title, Alert.Message,
                                  Alert.PrimaryButtonTitle, Alert.PrimaryButtonAction, AlertViewModel.Action.ButtonType = .normal,
                                  Alert.SecondaryButtonTitle, Alert.SecondaryButtonAction, AlertViewModel.Action.ButtonType = .cancel)
}

enum AlertPresentationType {
    case alert
    case actionSheet
}
