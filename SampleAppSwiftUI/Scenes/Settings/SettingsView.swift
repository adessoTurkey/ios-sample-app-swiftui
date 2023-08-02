//
//  SettingsView.swift
//  SampleAppSwiftUI
//
//  Created by Cakir, Faik on 18.03.2023.
//

import SwiftUI

struct SettingsView: View {

    @State private var isDarkModeOn = false
    @State private var selectedParity: Parity = .USD
    @Binding var router: Router

    var body: some View {
        NavigationStack(path: $router.settingsNavigationPath) {
            VStack(alignment: .leading, spacing: Spacings.settings) {
                viewTitle
                darkButton
                paritySelection
                Spacer()
                removeButton
            }
            .padding([.leading, .trailing], Spacings.settings)
            .edgesIgnoringSafeArea(.top)
        }
    }
}

extension SettingsView {
    private var viewTitle: some View {
        VStack {
            HStack {
                Text("Settings")
                    .settingsTextStyle(fontType: .bold, fontSize: .title2, foregroundColor: .settingsViewTitle)
                Spacer()
            }
        }
        .padding(.top, Paddings.titleTop)
    }

    private var darkButton: some View {
        VStack {
            Toggle("Dark Mode:", isOn: $isDarkModeOn)
                .settingsTextStyle(fontSize: .body, foregroundColor: .settingsLineTitle)
                .settingsLineStyle(height: Dimensions.lineHeight)
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }

    private var paritySelection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Currency")
                    .settingsTextStyle(fontSize: .body, foregroundColor: .settingsLineTitle)
                Spacer()
                Picker("Parities", selection: $selectedParity) {
                    ForEach(Parity.allCases) { parity in
                        Text(parity.rawValue)
                            .accessibilityIdentifier("settingsViewParitySelectionPickerCell")
                    }
                }
                .tint(Color(.settingsParitySet))
                .accessibilityIdentifier("settingsViewParitySelectionPicker")
            }
            .settingsLineStyle(height: Dimensions.lineHeight)
            .padding(.bottom, Spacings.home)

            Text("baseCoinChangeInfo")
                .settingsTextStyle(fontType: .regular, fontSize: .caption2, foregroundColor: .settingsCurrencyExp)
        }
    }

    private var removeButton: some View {
        Button {
            print("Make an action")
        } label: {
            Text("Remove All Data")
                .settingsTextStyle(fontType: .bold, fontSize: .body)
                .foregroundStyle(.white)
        }
        .settingsButtonStyle()
    }
}

#Preview {
    SettingsView(router: .constant(.init()))
}
