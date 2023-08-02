//
//  CoinChartHistoryRangeButtons.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 30.05.2023.
//

import PreviewSnapshots
import SwiftUI

struct CoinChartHistoryRangeButtons: View {
    @Binding var selection: CoinChartHistoryRange

    var body: some View {
        HStack(spacing: 16) {
            ForEach(CoinChartHistoryRange.allCases) { range in
                Button {
                    selection = range
                } label: {
                    Text(range.rawValue)
                        .font(.caption2.bold())
                        .padding(8)
                        .foregroundColor(range == selection ? .white : .label)
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
                .background(content: {
                    if range == selection {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(uiColor: .systemBlue))
                    }
                })
            }
        }
    }
}

struct CoinChartHistoryRangeButtons_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews
    }

    static var snapshots: PreviewSnapshots<CoinChartHistoryRange> {
        .init(configurations: [
            .init(name: "One day", state: .oneDay),
            .init(name: "One week", state: .oneWeek),
            .init(name: "One month", state: .oneMonth),
            .init(name: "Three months", state: .threeMonth),
            .init(name: "Six months", state: .sixMonth),
            .init(name: "One year", state: .oneYear),
            .init(name: "All dates", state: .all)
        ]) { state in
            CoinChartHistoryRangeButtons(selection: .constant(state))
        }
    }
}
