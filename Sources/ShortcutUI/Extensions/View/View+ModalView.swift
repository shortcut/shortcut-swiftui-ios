//
//  View+Extension.swift
//  ShortcutUI
//
//  Created by Darya Gurinovich on 2022-01-07.
//  Copyright © 2022 Shortcut Scandinavia Apps AB. All rights reserved.
//

import SwiftUI
#if !os(macOS)
import UIKit
#endif

/// Fixes issues related to having multiple .sheet() or .fullScreenCover() functions in the same view hierarchy that SwiftUI can't handle

public extension View {
    func sheetWithoutConflicts<Item, Content>(item: Binding<Item?>,
                                              onDismiss: (() -> Void)? = nil,
                                              @ViewBuilder content: @escaping (Item) -> Content) -> some View
    where Item: Identifiable, Content: View {
        self.overlay(
            EmptyView().sheet(item: item, onDismiss: onDismiss, content: content)
        )
    }

    func sheetWithoutConflicts<Content>(isPresented: Binding<Bool>,
                                        onDismiss: (() -> Void)? = nil,
                                        @ViewBuilder content: @escaping () -> Content) -> some View
    where Content: View {
        self.overlay(
            EmptyView().sheet(isPresented: isPresented, onDismiss: onDismiss, content: content)
        )
    }

    #if !os(macOS)
    @ViewBuilder
    func fullScreenCoverWithoutConflicts<Item, Content>(item: Binding<Item?>,
                                                        onDismiss: (() -> Void)? = nil,
                                                        @ViewBuilder content: @escaping (Item) -> Content) -> some View
    where Item: Identifiable, Content: View {
        if #available(iOS 14.0, watchOS 7.0, *) {
            self.overlay(
                EmptyView().fullScreenCover(item: item, onDismiss: onDismiss, content: content)
            )
        } else {
            self.sheetWithoutConflicts(item: item, onDismiss: onDismiss, content: content)
        }
    }

    @ViewBuilder
    func fullScreenCoverWithoutConflicts<Content>(isPresented: Binding<Bool>,
                                                  onDismiss: (() -> Void)? = nil,
                                                  @ViewBuilder content: @escaping () -> Content) -> some View
    where Content: View {
        if #available(iOS 14.0, watchOS 7.0, *) {
            self.overlay(
                EmptyView().fullScreenCover(isPresented: isPresented, onDismiss: onDismiss, content: content)
            )
        } else {
            self.sheetWithoutConflicts(isPresented: isPresented, onDismiss: onDismiss, content: content)
        }
    }
    #endif
}
