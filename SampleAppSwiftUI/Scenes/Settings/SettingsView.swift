//
//  SettingsView.swift
//  SampleAppSwiftUI
//
//  Created by Faik Coskun Cakir, Faik on 18.03.2023.
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

extension SettingsView {
    private var viewTitle: some View {
        VStack {
            HStack {
                Text("Settings")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.settingsViewTitleColor)
                Spacer()
            }
        }
    }
}

extension SettingsView {
    private var darkButton: some View {
        VStack {
            Toggle("Dark Mode:", isOn: $isDarkModeOn)
                .foregroundColor(Color.settingsLineTitleColor)
                .padding(8)
                .frame(height: 44)
                .background(Color.settingsLineColor)
                .cornerRadius(8)
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}

extension SettingsView {
    private var paritySelection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Currency")
                    .bold()
                    .foregroundColor(Color.settingsLineTitleColor)
                Spacer()
                Picker("Parities", selection: $selectedParity) {
                    ForEach(Parities.allCases) { parity in
                        Text(parity.rawValue)
                    }
                }
                .tint(Color.settingsParitySetColor)
            }
            .padding(8)
            .frame(height: 50)
            .background(Color.settingsLineColor)
            .cornerRadius(8)
            .padding(.bottom, 10)

            Text("When you select a new base currency, all prices in the app will be displayed in that currency.")
                .foregroundColor(.settingsCurrencyExpColor)
                .font(.caption2)
                .fontWeight(.regular)
        }
    }
}

extension SettingsView {
    private var removeButton: some View {
        Button {
            print("Make an action")
        } label: {
            Text("Remove All Data")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color.settingsButtonColor)
        .cornerRadius(8)
        .padding(.bottom, 14)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
