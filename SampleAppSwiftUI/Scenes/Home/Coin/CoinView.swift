//
//  CoinView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 21.03.2023.
//

import SwiftUI

struct CoinView: View {

    var coinInfo: CoinInfo
    @ObservedObject var viewModel: CoinInfoViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Dimensions.CornerRadius.default)
                .fill(Color.coinCellBackground)
            HStack {
                AsyncImage(url: viewModel.getURL(from: coinInfo.code)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .imageFrame()
                    } else if phase.error != nil {
                        VStack {
                            Image(systemName: Images.close)
                                .foregroundColor(.red)
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
                    Text(coinInfo.title)
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

    func configureTextColor(_ coinInfo: CoinInfo) -> Color {
        coinInfo.changeAmount < 0 ? .red : .green
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
