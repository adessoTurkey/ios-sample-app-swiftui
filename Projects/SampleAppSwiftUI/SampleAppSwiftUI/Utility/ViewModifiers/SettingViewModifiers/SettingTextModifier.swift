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
    let foregroundColor: ColorResource

    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color(foregroundColor))
            .font(fontSize.weight(fontType))
    }
}

extension View {
    func settingsTextStyle(fontType: Font.Weight = .regular, fontSize: Font, foregroundColor: ColorResource = .color) -> some View {
        modifier(SettingTextModifier(fontType: fontType, fontSize: fontSize, foregroundColor: foregroundColor))
    }
}
