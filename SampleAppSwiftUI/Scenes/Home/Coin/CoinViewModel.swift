//
//  CoinViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 23.03.2023.
//

import SwiftUI

class CoinInfoViewModel: ObservableObject {

    @AppStorage("favoriteCoins") var favoriteCoins: [String] = []

    func isCoinFavorite(code: String) -> Bool {
        favoriteCoins.contains(code)
    }

    func checkFavorite(code: String) {
        if favoriteCoins.isEmpty {
            addFavoriteCoin(code: code)
        } else {
            if isCoinFavorite(code: code) {
                removeFavoriteCoin(code: code)
            } else {
                addFavoriteCoin(code: code)
            }
        }
    }

    private func addFavoriteCoin(code: String) {
        DispatchQueue.main.async {
            self.favoriteCoins.append(code)
        }
    }

    private func removeFavoriteCoin(code: String) {
        DispatchQueue.main.async {
            self.favoriteCoins.removeAll(where: { $0 == code })
        }
    }

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

    func manageFavorites(code: String) -> String {
        let output = isCoinFavorite(code: code) ? "Removed from Favorites" : "Added to Favorites"
        checkFavorite(code: code)
        return output
    }
}
