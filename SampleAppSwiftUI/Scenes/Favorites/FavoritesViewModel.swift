//
//  FavoritesViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 27.03.2023.
//

import Foundation
import SwiftUI
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var coins: [CoinData] = []
    @Published var filteredCoins: [CoinData] = []

    func fetchFavorites() {
        fetchDemoModel()
        getFavoriteCoinList()
    }

    private func getFavoriteCoinList() {
        if StorageManager.shared.favoriteCoins.isEmpty {
            filteredCoins.removeAll()
        } else {
            filteredCoins = coins.filter({ coin in
                if let info = coin.coinInfo,
                   let code = info.code {
                    return StorageManager.shared.isCoinFavorite(code: code)
                } else {
                    return false
                }
            })
        }
    }

    private func fetchDemoModel() {
        if let demoDataPath = Bundle.main.path(forResource: "CoinList", ofType: "json") {
            let pathURL = URL(fileURLWithPath: demoDataPath)
            do {
                let data = try Data(contentsOf: pathURL, options: .mappedIfSafe)
                let coinList = try JSONDecoder().decode([CoinData].self, from: data)
                self.fillDemoData(coinList: coinList)
            } catch let error {
                print(error)
            }
        }
    }

    private func fillDemoData(coinList: [CoinData]) {
        self.coins = coinList
        self.filteredCoins = coinList
    }

    func filterResults(searchTerm: String = "") {
        if !searchTerm.isEmpty {
            filteredCoins = coins.filter { coin in
                if let coinCode = coin.coinInfo?.code {
                    return coin.coinInfo?.title?.lowercased().contains(searchTerm.lowercased()) ?? true ||
                    coin.coinInfo?.code?.lowercased().contains(searchTerm.lowercased())  ?? true &&
                    StorageManager.shared.favoriteCoins.contains(coinCode)
                } else {
                    return false
                }
            }
        } else {
            filteredCoins = coins.filter({ coin in
                if let coinInfo = coin.coinInfo,
                   let coinCode = coinInfo.code {
                    return StorageManager.shared.favoriteCoins.contains(coinCode)
                } else {
                    return false
                }
            })
        }
    }
}
