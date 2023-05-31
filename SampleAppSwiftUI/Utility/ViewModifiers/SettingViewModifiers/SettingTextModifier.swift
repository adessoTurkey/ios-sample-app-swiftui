//
//  TextModifier.swift
//  SampleAppSwiftUI
//
//  Created by Cakir, Faik on 20.03.2023.
//

import SwiftUI

struct SettingTextModifier: ViewModifier {
    let fontType: Font.Weight
    let fontSize: Font
    let foregroundColor: Color

    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .font(fontSize.weight(fontType))
    }
}

extension View {
    func settingsTextStyle(fontType: Font.Weight = .regular, fontSize: Font, foregroundColor: Color) -> some View {
        modifier(SettingTextModifier(fontType: fontType, fontSize: fontSize, foregroundColor: foregroundColor))
    }
}
