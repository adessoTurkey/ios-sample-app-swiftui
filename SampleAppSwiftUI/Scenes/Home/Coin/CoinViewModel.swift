//
//  CoinViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 23.03.2023.
//

import SwiftUI

class CoinInfoViewModel: ObservableObject {

    func createPriceString(coinInfo: CoinInfo) -> String {
        coinInfo.price.formatted(.currency(code: "USD").precision(.fractionLength(Range.currency)))
    }

    func getURL(from code: String) -> URL? {
        URL(string: "\(URLs.Icons.baseURL)\(code.lowercased())\(URLs.Icons.scaleURL)")
    }

    func createChangeText(coinInfo: CoinData) -> String {
        "\(createPercentageText(coinInfo)) (\(createAmountText(coinInfo)))"
    }

    private func createPercentageText(_ coinInfo: CoinInfo) -> String {
        (coinInfo.changePercentage / 100)
            .formatted(.percent.precision(.fractionLength(Range.currency)))
    }

    private func createAmountText(_ coinInfo: CoinData) -> String {
        coinInfo.detail?.usd?.changeAmount?
            .formatted(.currency(code: "USD")
                .precision(.fractionLength(Range.currency))) ?? "CoinInfoViewModel Error"
    }
}
