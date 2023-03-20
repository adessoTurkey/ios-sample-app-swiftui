//
//  SettingsView.swift
//  SampleAppSwiftUI
//
//  Created by Cakir, Faik on 18.03.2023.
//

import SwiftUI

enum Parities: String, CaseIterable, Identifiable {
    case USD, ETH, AVAX

    var id: Self { self }
}

struct SettingsView: View {

    private let spaceSize: CGFloat = 18
    @State private var isDarkModeOn = false
    @State private var selectedParity: Parities = .USD

    var body: some View {
        VStack(alignment: .leading, spacing: spaceSize) {
            Spacer()
                .frame(height: 75)
            viewTitle
            darkButton
            paritySelection
            Spacer()
            removeButton
        }
        .padding([.leading, .trailing], spaceSize)
        .edgesIgnoringSafeArea(.top)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var viewTitle: some View {
        VStack {
            HStack {
                Text("Settings")
                    .modifier(SettingTextModifier(fontType: .bold, fontSize: .title2, foregroundColor: .settingsViewTitleColor))
                Spacer()
            }
        }
    }
}

extension SettingsView {
    private var darkButton: some View {
        VStack {
            Toggle("Dark Mode:", isOn: $isDarkModeOn)
                .modifier(SettingTextModifier(fontType: .bold, fontSize: .body, foregroundColor: .settingsLineTitleColor))
                .modifier(SettingLineModifier(height: 44))
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}

extension SettingsView {
    private var paritySelection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Currency")
                    .modifier(SettingTextModifier(fontType: .bold, fontSize: .body, foregroundColor: .settingsLineTitleColor))
                Spacer()
                Picker("Parities", selection: $selectedParity) {
                    ForEach(Parities.allCases) { parity in
                        Text(parity.rawValue)
                    }
                }
                .tint(Color.settingsParitySetColor)
            }
            .modifier(SettingLineModifier(height: 50))

            Text("When you select a new base currency, all prices in the app will be displayed in that currency.")
                .modifier(SettingTextModifier(fontType: .regular, fontSize: .caption2, foregroundColor: .settingsCurrencyExpColor))
        }
    }
}

extension SettingsView {
    private var removeButton: some View {
        Button {
            print("Make an action")
        } label: {
            Text("Remove All Data")
                .modifier(SettingTextModifier(fontType: .bold, fontSize: .body, foregroundColor: .white))
        }
        .modifier(SettingButtonModifier())
    }
}
