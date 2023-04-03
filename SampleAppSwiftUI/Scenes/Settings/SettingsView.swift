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

    var body: some View {
        VStack(alignment: .leading, spacing: Numbers.settingsSpacing) {
            viewTitle
            darkButton
            paritySelection
            Spacer()
            removeButton
        }
        .padding([.leading, .trailing], Numbers.settingsSpacing)
        .edgesIgnoringSafeArea(.top)
    }
}

extension SettingsView {
    private var viewTitle: some View {
        VStack {
            HStack {
                Text("Settings")
                    .settingsTextStyle(fontType: .bold, fontSize: .title2, foregroundColor: .settingsViewTitleColor)
                Spacer()
            }
        }
        .padding(.top, Numbers.titleTopPadding)
    }

    private var darkButton: some View {
        VStack {
            Toggle("Dark Mode:", isOn: $isDarkModeOn)
                .settingsTextStyle(fontType: .bold, fontSize: .body, foregroundColor: .settingsLineTitleColor)
                .settingsLineStyle(height: Numbers.lineHeight)
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }

    private var paritySelection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Currency")
                    .settingsTextStyle(fontType: .bold, fontSize: .body, foregroundColor: .settingsLineTitleColor)
                Spacer()
                Picker("Parities", selection: $selectedParity) {
                    ForEach(Parity.allCases) { parity in
                        Text(parity.rawValue)
                    }
                }
                .tint(.settingsParitySetColor)
            }
            .settingsLineStyle(height: Numbers.lineHeight)
            .padding(.bottom, Numbers.homeSpacing)

            Text("When you select a new base currency, all prices in the app will be displayed in that currency.")
                .settingsTextStyle(fontType: .regular, fontSize: .caption2, foregroundColor: .settingsCurrencyExpColor)
        }
    }

    private var removeButton: some View {
        Button {
            print("Make an action")
        } label: {
            Text("Remove All Data")
                .settingsTextStyle(fontType: .bold, fontSize: .body, foregroundColor: .white)
        }
        .settingsButtonStyle()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
