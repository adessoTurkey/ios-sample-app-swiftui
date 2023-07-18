//
//  CoinView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 21.03.2023.
//

import PreviewSnapshots
import SwiftUI

struct CoinView: View {
    var coinInfo: CoinData

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Dimensions.CornerRadius.default)
                .fill(Color.coinCellBackground)
            HStack {
                AsyncImage(url: URLs.Icons.getURL(from: coinInfo.coinInfo?.code ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .imageFrame()
                    } else if phase.error != nil {
                        VStack {
                            Resources.Images.defaultCoin.swiftUIImage
                                .resizable()
                                .imageFrame()
                        }
                    } else {
                        ProgressView()
                            .imageFrame()
                    }
                }
                .scaledToFit()
                .imageFrame()

                VStack(alignment: .leading, spacing: Spacings.default) {
                    if let coinInfo = coinInfo.coinInfo {
                        Text(coinInfo.code ?? "")
                            .font(Fonts.coin)
                            .bold()
                        Text(limitTextCharacter(for: coinInfo.title ?? "", limit: Numbers.coinTitleCharacterLimit))
                            .lineLimit(Numbers.coinTitleLineLimit)
                            .font(Fonts.coinName)
                            .foregroundColor(Color(uiColor: .systemGray))
                    }
                }
                Spacer()
                VStack(alignment: .trailing, spacing: Spacings.default) {
                    if let rawData = coinInfo.detail,
                       let usd = rawData.usd {
                        Text(usd.createPriceString())
                            .font(Fonts.coin)
                            .bold()
                        Text(usd.createChangeText())
                            .font(Fonts.coinAmount)
                            .foregroundColor(configureTextColor(usd))
                    }
                }
            }
            .padding(.horizontal, Paddings.side)
        }
        .frame(height: Dimensions.coinCellSize)
    }

    func limitTextCharacter(for text: String, limit: Int) -> Substring {
        if text.count > limit {
            return "\(text.prefix(limit))..."
        } else {
            return text.prefix(limit)
        }
    }

    func configureTextColor(_ rawData: RawUsd) -> Color {
        rawData.changePercentage ?? Numbers.absoluteZero < Numbers.absoluteZero ? .red : .green
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews
            .previewLayout(.sizeThatFits)
            .frame(height: Dimensions.coinCellSize)
            .padding(.horizontal, Paddings.side)
            .padding(.vertical)
    }

    static var snapshots: PreviewSnapshots<CoinData> {
        PreviewSnapshots(configurations: [
            .init(name: "BTC", state: .demo),
            .init(name: "DOGE", state: CoinData.demoCoin(from: "DOGE")),
            .init(name: "ETH", state: CoinData.demoCoin(from: "ETH"))
        ], configure: { state in CoinView(coinInfo: state) })
    }
}
