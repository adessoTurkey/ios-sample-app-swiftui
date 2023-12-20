//
//  StorageManager.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 4.04.2023.
//

import SwiftUI

final class StorageManager {

    static let shared = StorageManager()

    @AppStorage("favoriteCoins") var favoriteCoins: [CoinUIModel] = []

    private init() { }

    func isCoinFavorite(_ coinCode: String) -> Bool {
        favoriteCoins.contains { coinData in
            if let coinInfo = coinData.coinInfo, let code = coinInfo.code {
                return code == coinCode
            }
            return false
        }
    }

    func toggleFavoriteCoin(coinData: CoinUIModel) {
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

    private func addFavoriteCoin(coinData: CoinUIModel) {
        DispatchQueue.main.async {
            self.favoriteCoins.append(coinData)
        }
    }

    private func removeFavoriteCoin(_ coinCode: String) {
        favoriteCoins.removeAll { coinData in
            if let coinInfo = coinData.coinInfo, let code = coinInfo.code {
                return code == coinCode
            }
            return false
        }
    }

    @discardableResult
    func manageFavorites(coinData: CoinUIModel) -> String {
        let output = isCoinFavorite(coinData.coinInfo?.code ?? "") ? "Removed from Favorites" : "Added to Favorites"
        toggleFavoriteCoin(coinData: coinData)
        return output
    }

}
