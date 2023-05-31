//
//  CoinChartHistorySegmentedControl.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 23.05.2023.
//

import SwiftUI

struct CoinChartHistorySegmentedControl: View {
    @Binding var selection: CoinChartHistoryRange

    init(selection: Binding<CoinChartHistoryRange>) {
        self._selection = selection

        let appearance = UISegmentedControl.appearance()
        appearance.selectedSegmentTintColor = .systemTeal
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
        appearance.backgroundColor = .clear
    }

    var body: some View {
        Picker("", selection: $selection) {
            ForEach(CoinChartHistoryRange.allCases, id: \.self) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

struct CoinChartHistorySegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        CoinChartHistorySegmentedControl(selection: .constant(.threeMonth))
    }
}
