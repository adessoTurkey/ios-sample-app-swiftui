//
//  CoinViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 23.03.2023.
//

import SwiftUI

class CoinInfoViewModel: ObservableObject {
    func createPriceString(coinInfo: CoinInfo) -> String {
        coinInfo.price.formatted(.currency(code: "USD").precision(.fractionLength(2...4)))
    }

    func getURL(from code: String) -> URL? {
        URL(string: "https://cryptoicons.org/api/icon/\(code.lowercased())/40")
    }

    func createChangeText(coinInfo: CoinInfo) -> String {
        """
\((coinInfo.changePercentage / 100)
.formatted(.percent)) (\(coinInfo.changeAmount
.formatted(.currency(code: "USD")
.precision(.fractionLength(2...4)))))
"""
    }
}
