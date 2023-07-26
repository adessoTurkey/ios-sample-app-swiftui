//
//  ChangePercentageView.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 22.05.2023.
//

import PreviewSnapshots
import SwiftUI

struct ChangePercentageView: View {
    let changeRate: RawUsd

    private var isRised: Bool {
        changeRate.changePercentage ?? 0 >= 0
    }

    var body: some View {
        HStack {
            Label(changeRate.createPercentageText(), systemImage: isRised ? Images.arrowUpSquare : Images.arrowDownSquare)
                .foregroundColor(isRised ? .green : .red)
                .font(.subheadline)
                .padding(.horizontal, Paddings.ChangePercentageView.side)
                .padding(.vertical, Paddings.ChangePercentageView.top)
        }
        .background(Color(uiColor: .systemGray5))
        .clipShape(Capsule())
    }
}

struct ChangePercentageView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews
    }

    static var snapshots: PreviewSnapshots<RawUsd> {
        .init(configurations: [
            .init(name: "Positive Change", state: CoinData.demo.detail?.usd ?? .init()),
            .init(name: "Neutral", state: RawUsd(changePercentage: 0)),
            .init(name: "Negative", state: RawUsd(changePercentage: -14.33))
        ]) { state in
            ChangePercentageView(changeRate: state)
        }
    }
}
