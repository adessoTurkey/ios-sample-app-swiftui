//
//  PaddingModifiers.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 3.04.2023.
//

import SwiftUI

struct SidePaddingModifier: ViewModifier {

    var size: CGFloat?

    func body(content: Content) -> some View {
        content
            .padding([.leading, .trailing], size)
    }
}

struct TopBottomPaddingModifier: ViewModifier {
    var size: CGFloat?

    func body(content: Content) -> some View {
        content
            .padding([.top, .bottom], size)
    }
}

extension View {
    func topBottomPadding(size: CGFloat? = nil) -> some View {
        modifier(TopBottomPaddingModifier(size: size))
    }

    func sidePadding(size: CGFloat? = nil) -> some View {
        modifier(SidePaddingModifier(size: size))
    }
}
