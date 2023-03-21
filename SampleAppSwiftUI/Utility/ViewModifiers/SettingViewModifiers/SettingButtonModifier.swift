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
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.settingsButtonColor)
            .cornerRadius(8)
            .padding(.bottom, 14)
    }
}
