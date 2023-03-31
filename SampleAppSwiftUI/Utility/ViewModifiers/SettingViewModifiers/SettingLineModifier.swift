//
//  LineModifier.swift
//  SampleAppSwiftUI
//
//  Created by Cakir, Faik on 20.03.2023.
//

import SwiftUI

struct SettingLineModifier: ViewModifier {
    let height: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(8)
            .frame(height: height)
            .background(Color.settingsLineColor)
            .cornerRadius(8)
    }
}

extension View {
    func settingsLineStyle(height: CGFloat) -> some View {
        modifier(SettingLineModifier(height: height))
    }
}
