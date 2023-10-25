//
//  StorageManager.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 4.04.2023.
//

import SwiftUI

final class StorageManager {

    static let shared = StorageManager()

    @AppStorage("favoriteCoins") var favoriteCoins: [CoinData] = []

    private init() { }

    func isCoinFavorite(_ coinCode: CoinCode) -> Bool {
        favoriteCoins.contains { coinData in
            if let coinInfo = coinData.coinInfo, let code = coinInfo.code {
                return code == coinCode
            }
            return false
        }
    }

    func toggleFavoriteCoin(coinData: CoinData) {
        if favoriteCoins.isEmpty {
            addFavoriteCoin(coinData: coinData)
        } else {
            if isCoinFavorite(coinData.coinInfo?.code ?? "") {
                removeFavoriteCoin(coinData.coinInfo?.code ?? "")
            } else {
                addFavoriteCoin(coinData: coinData)
            }
        }
    }

    private func addFavoriteCoin(coinData: CoinData) {
        DispatchQueue.main.async {
            self.favoriteCoins.append(coinData)
        }
    }

    private func removeFavoriteCoin(_ coinCode: CoinCode) {
        favoriteCoins.removeAll { coinData in
            if let coinInfo = coinData.coinInfo, let code = coinInfo.code {
                return code == coinCode
            }
            return false
        }
    }

    @discardableResult
    func manageFavorites(coinData: CoinData) -> String {
        let output = isCoinFavorite(coinData.coinInfo?.code ?? "") ? "Removed from Favorites" : "Added to Favorites"
        toggleFavoriteCoin(coinData: coinData)
        return output
    }

}
