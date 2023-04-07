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
    @Published var coins: [CoinInfo] = []
    @Published var filteredCoins: [CoinInfo] = []
    @StateObject private var storageManager = StorageManager.shared

    func fetchFavorites() {
        fetchDemoModel()
        getFavoriteCoinList()
    }

    private func getFavoriteCoinList() {
        if !storageManager.favoriteCoins.isEmpty {
            filteredCoins = coins.filter({ coin in
                storageManager.favoriteCoins.contains(coin.code)
            })
        } else {
            filteredCoins = []
        }
    }

    func removeFavorite(coin: CoinInfo) {
        storageManager.favoriteCoins.removeAll { code in
            code == coin.code
        }
        getFavoriteCoinList()
    }

    private func fetchDemoModel() {
        guard let coinList = JsonHelper.make([CoinInfo].self, .coinList) else { return }
        self.fillDemoData(coinList: coinList)
    }

    private func fillDemoData(coinList: [CoinInfo]) {
        self.coins = coinList
        self.filteredCoins = coinList
    }

    func filterResults(searchTerm: String = "") {
        if !searchTerm.isEmpty {
            filteredCoins = coins.filter { coin in
                coin.title.lowercased().contains(searchTerm.lowercased()) ||
                coin.code.lowercased().contains(searchTerm.lowercased()) &&
                storageManager.favoriteCoins.contains(coin.code)
            }
        } else {
            filteredCoins = coins.filter({ coin in
                storageManager.favoriteCoins.contains(coin.code)
            })
        }
    }
}
