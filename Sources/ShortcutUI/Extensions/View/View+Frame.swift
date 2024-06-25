//
//  View+Frame.swift
//  
//
//  Created by Karl Söderberg on 2024-06-25.
//

import SwiftUI

public extension View {
    @inlinable func height(_ value: CGFloat?, alignment: Alignment = .center) -> some View {
        frame(height: value, alignment: alignment)
    }

    @inlinable func width(_ value: CGFloat?, alignment: Alignment = .center) -> some View {
        frame(width: value, alignment: alignment)
    }

    @inlinable func maxHeight(_ value: CGFloat?, alignment: Alignment = .center) -> some View {
        frame(maxHeight: value, alignment: alignment)
    }

    @inlinable func maxWidth(_ value: CGFloat?, alignment: Alignment = .center) -> some View {
        frame(maxWidth: value, alignment: alignment)
    }
}
