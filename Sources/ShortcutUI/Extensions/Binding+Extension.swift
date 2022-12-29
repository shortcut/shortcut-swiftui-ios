//
//  Binding+Extension.swift
//  ShortcutUI
//
//  Created by Sheikh Bayazid on 2022-12-29.
//

import SwiftUI

public extension Binding {
    /// Creates a binding with a mutable mock value.
    ///
    /// Use this method to create a binding to a mock value that can change.
    /// This can be useful when using a ``PreviewProvider`` to see how a view
    /// represents different values and states.
    ///
    ///     // Example of binding to a mutable mock value.
    ///     Toggle("Switch", isOn: .mock(true))
    ///
    /// - Parameter value: A mutable mock value.
    static func mock(_ value: Value) -> Self {
        var mutableValue = value

        return Binding(
            get: { mutableValue },
            set: { mutableValue = $0 }
        )
    }
}
