// swiftlint:disable redundant_optional_initialization
// swiftlint:disable nesting
//
//  Alert+Extension.swift
//  ShortcutSwiftUI
//
//  Created by Sheikh Bayazid on 2022-02-14.
//  Copyright © 2022 Shortcut Scandinavia Apps AB. All rights reserved.
//

import SwiftUI

struct AlertViewModel {
    let title: String
    var message: String? = nil
    
    let primary: Action
    var secondary: Action? = nil
    
    struct Action {
        let title: String
        let action: () -> Void
        let buttonType: ButtonType
        
        enum ButtonType {
            case normal, cancel, destructive
        }
    }
}

extension AlertViewModel.Action {
    var alertButton: Alert.Button {
        switch self.buttonType {
        case .normal:
            return Alert.Button.default(Text(self.title), action: self.action)
        case .cancel:
            return Alert.Button.cancel(Text(self.title), action: self.action)
        case .destructive:
            return Alert.Button.destructive(Text(self.title), action: self.action)
        }
    }
}
