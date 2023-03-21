//
//  CoinView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 21.03.2023.
//

import SwiftUI

struct CoinView: View {

    var coinInfo: CoinInfo

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .tertiarySystemBackground))
            HStack {
                Image(coinInfo.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 8) {
                    Text(coinInfo.title)
                        .font(.system(size: 17))
                        .bold()
                    Text(coinInfo.code)
                        .foregroundColor(Color(uiColor: .systemGray))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 8) {
                    Text(coinInfo.price)
                        .font(.system(size: 17))
                        .bold()
                    Text("\(coinInfo.changePercentage) (\(coinInfo.changeAmount))")
                        .foregroundColor(coinInfo.changePercentage.contains("-") ? .red : .green)
                }
            }
            .padding([.trailing, .leading], 16)
        }
        .frame(height: 72)
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinView(coinInfo: .demo)
                .previewLayout(.sizeThatFits)
                .frame(height: 72)
                .padding([.top, .bottom])
            CoinView(coinInfo: .demo)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .frame(height: 72)
                .padding([.top, .bottom])
                .padding([.trailing, .leading], 16)

        }
    }
}

struct CoinInfo: Hashable, Identifiable {
    var id = UUID().uuidString
    var imageName: String
    var title: String
    var code: String
    var price: String
    var changePercentage: String
    var changeAmount: String

    static let demo = CoinInfo(imageName: "btc", title: "Bitcoin", code: "BTC", price: "$29,467.560", changePercentage: "29.74%", changeAmount: "$28.015")
    static let secondDemo = CoinInfo(imageName: "binance", title: "Binance", code: "BNB", price: "$23,5", changePercentage: "-24%", changeAmount: "$28.0")
}
