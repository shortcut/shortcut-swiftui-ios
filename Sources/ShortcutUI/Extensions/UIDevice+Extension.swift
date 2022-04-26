//
//  UIDevice+Extension.swift
//  ShortcutUI
//
//  Created by Sina Rabiei on 2022-03-30.
//  Copyright © 2022 Shortcut Scandinavia Apps AB. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIDevice {
    @available(iOS 15.0, *)
    var hasNotch: Bool {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let bottom = windowScene?.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
#endif
