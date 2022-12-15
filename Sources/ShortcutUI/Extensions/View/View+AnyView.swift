//
//  File.swift
//  
//
//  Created by Sheikh Bayazid on 2022-12-15.
//

import SwiftUI

public extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
