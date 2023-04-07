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

    func fetchFavorites() {
        fetchDemoModel()
        getFavoriteCoinList()
    }

    private func getFavoriteCoinList() {
        if StorageManager.shared.favoriteCoins.isEmpty {
            filteredCoins.removeAll()
        } else {
            filteredCoins = coins.filter({ coin in
                StorageManager.shared.favoriteCoins.contains(coin.code)
            })
        }
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
                StorageManager.shared.favoriteCoins.contains(coin.code)
            }
        } else {
            filteredCoins = coins.filter({ coin in
                StorageManager.shared.favoriteCoins.contains(coin.code)
            })
        }
    }
}
