//
//  LightShadowModifier.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 31.03.2023.
//

import SwiftUI

struct LightShadowModifier: ViewModifier {

    var color: Color

    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: 15, y: 4)
    }
}

extension View {
    func lightShadow(color: Color) -> some View {
        modifier(LightShadowModifier(color: color))
    }
}
