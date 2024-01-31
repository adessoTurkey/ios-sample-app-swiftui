//
//  VisitedCoinsManager.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 29.12.2023.
//

import Foundation

class VisitedCoinsManager {

    private static let maxCoinsCount = 15
    private static let recentlyVisitedKey = "RecentlyVisitedCoins"

    private let defaults = UserDefaults.standard

    func addRecentlyVisitedCoin(_ coin: CoinUIModel) {
        var recentlyVisitedCoins = getRecentlyVisitedCoins()

        recentlyVisitedCoins.removeAll { $0.coinInfo?.code == coin.coinInfo?.code }

        recentlyVisitedCoins.insert(coin, at: 0)

        if recentlyVisitedCoins.count > Self.maxCoinsCount {
            recentlyVisitedCoins = Array(recentlyVisitedCoins.prefix(Self.maxCoinsCount))
        }

        if let encodedData = try? JSONEncoder().encode(recentlyVisitedCoins) {
            defaults.set(encodedData, forKey: Self.recentlyVisitedKey)
        }
    }

    func getRecentlyVisitedCoins() -> [CoinUIModel] {
        guard let savedData = defaults.data(forKey: Self.recentlyVisitedKey),
           let decodedData = try? JSONDecoder().decode([CoinUIModel].self, from: savedData) else {
            return []
        }
        return decodedData
    }

    func clearRecentlyVisitedCoins() {
        defaults.removeObject(forKey: Self.recentlyVisitedKey)
    }
}
