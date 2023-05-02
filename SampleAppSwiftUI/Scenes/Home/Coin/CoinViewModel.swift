//
//  CoinViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 23.03.2023.
//

import SwiftUI

class CoinInfoViewModel: ObservableObject {

    func createPriceString(rawData: RawUsd) -> String {
        rawData.price?.formatted(.currency(code: "USD").precision(.fractionLength(Range.currency))) ?? ""
    }

    func getURL(from code: String) -> URL? {
        URL(string: "\(URLs.Icons.baseURL)\(code.lowercased())\(URLs.Icons.scaleURL)")
    }

    func createChangeText(rawData: RawUsd) -> String {
        "\(createPercentageText(rawData)) (\(createAmountText(rawData)))"
    }

    private func createPercentageText(_ rawData: RawUsd) -> String {
        ((rawData.changePercentage ?? 0) / 100)
            .formatted(.percent.precision(.fractionLength(Range.currency)))
    }

    private func createAmountText(_ rawData: RawUsd) -> String {
        rawData.changeAmount?
            .formatted(.currency(code: "USD")
                .precision(.fractionLength(Range.currency))) ?? "CoinInfoViewModel Error"
    }
}
