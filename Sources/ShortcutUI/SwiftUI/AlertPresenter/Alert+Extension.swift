//
//  Alert+Extension.swift
//  ShortcutUI
//
//  Created by Sheikh Bayazid on 2022-02-14.
//  Copyright © 2022 Shortcut Scandinavia Apps AB. All rights reserved.
//

import SwiftUI

public extension Alert {
    init(vm: AlertViewModel) {
        if let secondary = vm.secondary {
            self.init(title: Text(vm.title),
                      message: vm.message?.text,
                      primaryButton: vm.primary.alertButton,
                      secondaryButton: secondary.alertButton)
            
        } else {
            self.init(title: Text(vm.title),
                      message: vm.message?.text,
                      dismissButton: vm.primary.alertButton)
        }
    }
}

public extension Alert {
    typealias Title = String
    typealias Message = String
    
    typealias DismissButtonTitle = String
    typealias PrimaryButtonTitle = String
    typealias SecondaryButtonTitle = String
    
    typealias DismissButtonAction = () -> Void
    typealias PrimaryButtonAction = () -> Void
    typealias SecondaryButtonAction = () -> Void
}
