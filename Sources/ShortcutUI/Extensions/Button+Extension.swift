//
//  Button+Extension.swift
//  ShortcutUI
//
//  Created by Sina Rabiei on 2022-05-23.
//  Copyright © 2022 Shortcut Scandinavia Apps AB. All rights reserved.

import SwiftUI

public extension Button {
    init(priority: TaskPriority? = nil, action: @escaping () async -> Void, @ViewBuilder label: () -> Label) {
        self = Button(action: {
            Task(priority: priority) {
                await action()
            }
        }, label: label)
    }
}
