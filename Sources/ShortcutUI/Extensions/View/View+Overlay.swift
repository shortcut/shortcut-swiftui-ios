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
    ///     struct ExampleView: View {
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
    func overlay<Content>(alignment: Alignment = .center, isPresented: Bool, @ViewBuilder content: () -> Content) -> some View where Content: View {
        overlay(
            isPresented ? content() : nil,
            alignment: alignment
        )
    }

    /// Presents an overlay using the given item as a data source for the overlay's content.
    ///
    /// Use this method when you need to present an overlay view with content
    /// from a custom data source. The example below shows a custom data source
    /// `Person` that the `content` closure uses to populate the display
    /// the action overlay shows to the user:
    ///
    ///     struct ExampleView: View {
    ///         @State var personDetail: Person?
    ///
    ///         var body: some View {
    ///             Button("Show Details In Overlay") {
    ///                 personDetail = Person(
    ///                     name: "Sheikh Bayazid",
    ///                     language: "Bangla",
    ///                     country: "Bangladesh"
    ///                 )
    ///             }
    ///             .overlay(item: personDetail) { detail in
    ///                 VStack(alignment: .leading, spacing: 16) {
    ///                     Text("Name: \(detail.name)")
    ///                     Text("Language: \(detail.language)")
    ///                     Text("Country: \(detail.country)")
    ///                 }
    ///                 .frame(width: 300, height: 200)
    ///                 .background(Color.green)
    ///                 .cornerRadius(20)
    ///                 .onTapGesture {
    ///                     personDetail = nil
    ///                 }
    ///             }
    ///             .animation(.default, value: personDetail != nil)
    ///         }
    ///     }
    ///
    ///     struct Person: Identifiable {
    ///         let id = UUID().uuidString
    ///         let name: String
    ///         let language: String
    ///         let country: String
    ///     }
    ///
    /// - Parameters:
    ///   - alignment: The alignment of the overlay content that you create in the modifier's
    ///     `content` closure.. The default is `Alignment/center`.
    ///   - item: An optional source of truth for the overlay.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a overlay that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the overlay and replaces it with a new one
    ///     using the same process.
    ///   - content: A closure returning the content of the overlay.
    @ViewBuilder
    func overlay<Item, Content>(alignment: Alignment = .center, item: Item?, @ViewBuilder content: (Item) -> Content) -> some View where Item: Identifiable, Content: View {
        overlay(
            Group {
                if let item = item {
                    content(item)
                }
            },
            alignment: alignment
        )
    }
}
