//
//  CoinViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 23.03.2023.
//

import SwiftUI

class CoinInfoViewModel: ObservableObject {

    @AppStorage("favoriteList") var favoriteListData: Data?

    func createPriceString(coinInfo: CoinInfo) -> String {
        coinInfo.price.formatted(.currency(code: "USD").precision(.fractionLength(2...4)))
    }

    func getURL(from code: String) -> URL? {
        URL(string: "\(URLs.Icons.baseURL)\(code.lowercased())/\(Dimensions.imageWidth)")
    }

    func createChangeText(coinInfo: CoinInfo) -> String {
        "\(createPercentageText(coinInfo)) (\(createAmountText(coinInfo)))"
    }

    private func createPercentageText(_ coinInfo: CoinInfo) -> String {
        (coinInfo.changePercentage / 100)
            .formatted(.percent)
    }

    private func createAmountText(_ coinInfo: CoinInfo) -> String {
        coinInfo.changeAmount
            .formatted(.currency(code: "USD")
                .precision(.fractionLength(Range.currency)))
    }

    func manageFavorites(coinInfo: CoinInfo) -> String {
        if let favoriteListData {
            var favoriteList = (try? PropertyListDecoder().decode([CoinInfo].self, from: favoriteListData)) ?? [CoinInfo]()

            let index = favoriteList.firstIndex(of: coinInfo)
            if let index { // if its index can be found, it is also exist. So, it should be deleted.
                favoriteList.remove(at: index)
                if let data = try? PropertyListEncoder().encode(favoriteList) {
                    self.favoriteListData = data
                    return "Removed from Favorites"
                }
            } else {
                favoriteList.append(coinInfo)
                if let data = try? PropertyListEncoder().encode(favoriteList) {
                    self.favoriteListData = data
                    return "Added to Favorites"
                }
            }
        }
        return "Couldn't make changes,\nthere is a problem."
    }
}
