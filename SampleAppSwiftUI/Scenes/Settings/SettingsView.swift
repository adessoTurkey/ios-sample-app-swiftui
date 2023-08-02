//
//  SettingsView.swift
//  SampleAppSwiftUI
//
//  Created by Cakir, Faik on 18.03.2023.
//

import PreviewSnapshots
import SwiftUI

struct SettingsView: View {

    @State private var isDarkModeOn = false
    @State private var selectedParity: Parity = .USD
    @EnvironmentObject private var router: Router
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
                    .settingsTextStyle(fontType: .bold, fontSize: .title2, foregroundColor: .settingsViewTitleColor)
                Spacer()
            }
        }
        .padding(.top, Paddings.titleTop)
    }

    private var darkButton: some View {
        VStack {
            Toggle("Dark Mode:", isOn: $isDarkModeOn)
                .settingsTextStyle(fontSize: .body, foregroundColor: .settingsLineTitleColor)
                .settingsLineStyle(height: Dimensions.lineHeight)
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }

    private var paritySelection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Currency")
                    .settingsTextStyle(fontSize: .body, foregroundColor: .settingsLineTitleColor)
                Spacer()
                Picker("Parities", selection: $selectedParity) {
                    ForEach(Parity.allCases) { parity in
                        Text(parity.rawValue)
                            .accessibilityIdentifier("settingsViewParitySelectionPickerCell")
                    }
                }
                .tint(.settingsParitySetColor)
                .accessibilityIdentifier("settingsViewParitySelectionPicker")
            }
            .settingsLineStyle(height: Dimensions.lineHeight)
            .padding(.bottom, Spacings.home)

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
    static private let router = Router()

    static var previews: some View {
        snapshots.previews
    }

    static var snapshots: PreviewSnapshots<Void?> {
        .init(configurations: [
            .init(name: "Settings view", state: nil)
        ]) { _ in
            SettingsView()
                .environmentObject(router)
        }
    }
}
