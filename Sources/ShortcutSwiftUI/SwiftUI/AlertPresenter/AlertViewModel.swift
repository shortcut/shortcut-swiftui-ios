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

public struct AlertViewModel {
    public let title: String
    public var message: String? = nil
    
    public let primary: Action
    public var secondary: Action? = nil
    
    public struct Action {
        public let title: String
        public let action: () -> Void
        public let buttonType: ButtonType
        
        public enum ButtonType {
            case normal, cancel, destructive
        }
    }
}

extension AlertViewModel.Action {
    public var alertButton: Alert.Button {
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
