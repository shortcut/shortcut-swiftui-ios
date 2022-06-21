//
//  NavigationLink+Button.swift
//  ShortcutUI
//
//  Created by Swathi on 2022-06-09.
//  Copyright © 2021 Shortcut Scandinavia Apps AB. All rights reserved.
//

import Foundation
import SwiftUI

public struct NavigationLinkButton<Destination: View, Label: View>: View {
    var action: () -> Void
    var destination: () -> Destination
    var label: () -> Label

    @State private var isActive: Bool = false
    
   public init(action: @escaping () -> Void , destination: @escaping () -> Destination, label: @escaping () -> Label) {
        self.action = action
        self.destination = destination
        self.label = label
    }

    public var body: some View {
        Button(action: {
            self.action()
            self.isActive.toggle()
        }) {
            self.label()
              .background(
                ScrollView { // Fixes a bug where the navigation bar may become hidden on the pushed view
                    NavigationLink(destination: LazyDestination { self.destination() },
                                                 isActive: self.$isActive) { EmptyView() }
                }
              )
        }
    }
}

// This view lets us avoid instantiating our Destination before it has been pushed.
public struct LazyDestination<Destination: View>: View {
    var destination: () -> Destination
    public var body: some View {
        self.destination()
    }
}
