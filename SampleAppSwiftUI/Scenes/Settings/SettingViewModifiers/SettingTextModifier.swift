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
