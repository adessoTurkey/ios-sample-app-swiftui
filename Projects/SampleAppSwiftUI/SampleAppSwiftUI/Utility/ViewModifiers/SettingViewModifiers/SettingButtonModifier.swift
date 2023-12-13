//
//  ButtonModifier.swift
//  SampleAppSwiftUI
//
//  Created by Cakir, Faik on 20.03.2023.
//

import SwiftUI

struct SettingButtonModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: Dimensions.settingsButonHeight)
            .background(Color(.settingsButton))
            .cornerRadius(Dimensions.CornerRadius.settingsButton)
            .padding(.bottom, Paddings.Settings.bottom)
    }
}

extension View {
    func settingsButtonStyle() -> some View {
        modifier(SettingButtonModifier())
    }
}
