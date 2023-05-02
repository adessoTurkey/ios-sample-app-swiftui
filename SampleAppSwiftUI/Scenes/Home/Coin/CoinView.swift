//
//  CoinView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 21.03.2023.
//

import SwiftUI

struct CoinView: View {

    var coinInfo: CoinData
    @ObservedObject var viewModel: CoinInfoViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Dimensions.CornerRadius.default)
                .fill(Color.coinCellBackground)
            HStack {
                AsyncImage(url: viewModel.getURL(from: coinInfo.coinInfo?.code ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .imageFrame()
                    } else if phase.error != nil {
                        VStack {
                            Image("default-coin")
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
                    Text(coinInfo.code)
                        .font(Fonts.coin)
                        .bold()
                    Text(limitTextCharacter(for: coinInfo.title, limit: Numbers.coinTitleCharacterLimit))
                        .lineLimit(Numbers.coinTitleLineLimit)
                        .font(Fonts.coinName)
                        .foregroundColor(Color(uiColor: .systemGray))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: Spacings.default) {
                    Text(viewModel.createPriceString(coinInfo: coinInfo))
                        .font(Fonts.coin)
                        .bold()
                    Text(viewModel.createChangeText(coinInfo: coinInfo))
                        .font(Fonts.coinAmount)
                        .foregroundColor(configureTextColor(coinInfo))
                }
            }
            .sidePadding(size: Paddings.side)
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

    func configureTextColor(_ coinInfo: CoinInfo) -> Color {
        coinInfo.changeAmount < Numbers.absoluteZero ? .red : .green
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinView(coinInfo: .demo, viewModel: .init())
            CoinView(coinInfo: .demo, viewModel: .init())
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .frame(height: Dimensions.coinCellSize)
        .topBottomPadding()
        .sidePadding(size: Paddings.side)
    }
}
