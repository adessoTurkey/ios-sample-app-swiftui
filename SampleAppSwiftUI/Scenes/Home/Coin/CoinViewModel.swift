//
//  CoinViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 23.03.2023.
//

import SwiftUI

class CoinInfoViewModel: ObservableObject {

    func createPriceString(coinInfo: CoinData) -> String {
        coinInfo.detail?.usd?.price?.formatted(.currency(code: "USD").precision(.fractionLength(2...4))) ?? "CoinInfoViewModel Error"
    }

    func getURL(from code: String) -> URL? {
        URL(string: "\(URLs.Icons.baseURL)\(code.lowercased())/\(Dimensions.imageWidth)")
    }

    func createChangeText(coinInfo: CoinData) -> String {
        "\(createPercentageText(coinInfo)) (\(createAmountText(coinInfo)))"
    }

    private func createPercentageText(_ coinInfo: CoinData) -> String {
        ((coinInfo.detail?.usd?.changePercentage ?? 999.9) / 100)
            .formatted(.percent)
    }

    private func createAmountText(_ coinInfo: CoinData) -> String {
        coinInfo.detail?.usd?.changeAmount?
            .formatted(.currency(code: "USD")
                .precision(.fractionLength(Range.currency))) ?? "CoinInfoViewModel Error"
    }
}
