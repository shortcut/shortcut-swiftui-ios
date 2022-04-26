//
//  ActionSheet+Extension.swift
//  ShortcutUI
//
//  Created by Sheikh Bayazid on 2022-02-14.
//  Copyright © 2022 Shortcut Scandinavia Apps AB. All rights reserved.
//

import SwiftUI

public extension ActionSheet {
    init(vm: AlertViewModel) {
        self.init(title: Text(vm.title),
                  message: vm.message?.text,
                  buttons: [vm.primary.alertButton, vm.secondary?.alertButton].compactMap { $0 })
        
    }
}
