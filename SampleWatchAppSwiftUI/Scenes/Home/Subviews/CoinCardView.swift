//
//  CoinCardView.swift
//  SampleWatchAppSwiftUI
//
//  Created by Yildirim, Alper on 17.10.2023.
//

import SwiftUI

struct CoinCardView: View {
    let coin: CoinData

    var coinCodeText: String {
        coin.coinInfo?.code ?? ""
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(coinCodeText)
                    .font(.subheadline)
                    .lineLimit(1)
                Spacer()
                Text(coin.getPriceChangePercentageFormatted())
                    .font(.subheadline)
            }
            Text(coin.getCoinPriceFormatted())
                .lineLimit(1)
                .font(.title3)
        }
    }
}

struct CoinCardView_Previews: PreviewProvider {
    static var previews: some View {
        CoinCardView(coin: .demo)
    }
}
