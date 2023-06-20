//
//  ChangePercentageView.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 22.05.2023.
//

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
        ChangePercentageView(changeRate: CoinData.demo.detail?.usd ?? .init())
    }
}
