//
//  CoinDetailView.swift
//  SampleWatchAppSwiftUI
//
//  Created by Yildirim, Alper on 17.10.2023.
//

import SwiftUI

struct CoinDetailView: View {
    let coin: CoinData

    var coinCodeString: String {
        coin.coinInfo?.title ?? ""
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    PriceChartView(coin: coin)
                        .padding(.top, 12)

                    Text(coinCodeString)
                        .lineLimit(2)
                        .font(.subheadline)

                    Text(coin.getCoinPriceFormatted())
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(coin.getTitleColor())

                    HStack {
                        Text(coin.getPriceChangeAmountFormatted())
                            .font(.caption)

                        Text("(\(coin.getPriceChangePercentageFormatted()))")
                            .font(.caption2)
                    }
                }
                .padding()
            }
            .ignoresSafeArea()
            .toolbarBackground(.hidden, for: .navigationBar)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(coin.getBackgroundColor())
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coin: .demo)
    }
}
