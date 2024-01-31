//
//  FavoriteCoinsManager.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 29.12.2023.
//

import Foundation

class FavoriteCoinsManager {
    private let defaults = UserDefaults.standard
    private let favoritesKey = "FavoriteCoins"

    func addFavoriteCoin(_ coin: CoinUIModel) {
        var favoriteCoins = getFavoriteCoins()

        if !favoriteCoins.contains(where: { $0.coinInfo?.code == coin.coinInfo?.code }) {
            favoriteCoins.append(coin)


            saveFavorites(favoriteCoins)
        }
    }

    func removeFavoriteCoin(_ coin: CoinUIModel) {
        var favoriteCoins = getFavoriteCoins()

        favoriteCoins.removeAll { $0.id == coin.id }

        saveFavorites(favoriteCoins)
    }

    func getFavoriteCoins() -> [CoinUIModel] {
        if let savedData = defaults.data(forKey: favoritesKey),
           let decodedData = try? JSONDecoder().decode([CoinUIModel].self, from: savedData) {
            return decodedData
        }
        return []
    }

    func clearFavoriteCoins() {
        defaults.removeObject(forKey: favoritesKey)
    }

    func checkIfFavorite(_ coin: CoinUIModel) -> Bool {
        let favoriteCoins = getFavoriteCoins()
        return favoriteCoins.contains(where: { $0.coinInfo?.code == coin.coinInfo?.code })
    }

    private func saveFavorites(_ favorites: [CoinUIModel]) {
        if let encodedData = try? JSONEncoder().encode(favorites) {
            defaults.set(encodedData, forKey: favoritesKey)
        }
    }

}
