//
//  View+Overlay.swift
//  ShortcutUI
//
//  Created by Sheikh Bayazid on 2022-12-15.
//

import SwiftUI

public extension View {
    /// Presents an overlay when a Boolean value that you provide is true.
    ///
    /// Use this method when you want to present an overlay view to the
    /// user when a Boolean value you provide is true. The example
    /// below displays an overlay view when the user toggles the
    /// `isShowingOverlay` variable by clicking or tapping on
    /// the "Show overlay" button:
    ///
    ///     struct Example: View {
    ///         @State private var isShowingOverlay = false
    ///
    ///         var body: some View {
    ///             VStack(spacing: 50) {
    ///                Button("Show overlay") {
    ///                    isShowingOverlay.toggle()
    ///                }
    ///
    ///                RoundedRectangle(cornerRadius: 12)
    ///                    .fill(Color.blue)
    ///                    .overlay(isPresented: isShowingOverlay) {
    ///                        Text("Hello, world!")
    ///                    }
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - alignment: The alignment of the overlay content that you create in the modifier's
    ///     `content` closure.. The default is `Alignment/center`.
    ///   - isPresented: A Boolean value that determines whether
    ///     to present the overlay that you create in the modifier's `content` closure.
    ///   - content: A closure that returns the content of the overlay.
    @ViewBuilder
    func overlay<Content: View>(
        alignment: Alignment = .center,
        isPresented: Bool,
        content: () -> Content
    ) -> some View {
        overlay(
            isPresented ? content() : nil,
            alignment: alignment
        )
    }
}
