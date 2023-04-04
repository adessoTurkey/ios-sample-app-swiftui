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
    @StateObject private var storageViewModel = StorageManager.shared

    func fetchFavorites() {
        fetchDemoModel()
        getFavoriteCoinList()
    }

    private func getFavoriteCoinList() {
        if !storageViewModel.favoriteCoins.isEmpty {
            filteredCoins = coins.filter({ coin in
                storageViewModel.favoriteCoins.contains(coin.code)
            })
        } else {
            filteredCoins = []
        }
    }

    func removeFavorite(coin: CoinInfo) {
        storageViewModel.favoriteCoins.removeAll { code in
            code == coin.code
        }
        getFavoriteCoinList()
    }

    private func fetchDemoModel() {
        if let demoDataPath = Bundle.main.path(forResource: "CoinList", ofType: "json") {
            let pathURL = URL(fileURLWithPath: demoDataPath)
            do {
                let data = try Data(contentsOf: pathURL, options: .mappedIfSafe)
                let coinList = try JSONDecoder().decode([CoinInfo].self, from: data)
                self.fillDemoData(coinList: coinList)
            } catch let error {
                print(error)
            }
        }
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
                storageViewModel.favoriteCoins.contains(coin.code)
            }
        } else {
            filteredCoins = coins.filter({ coin in
                storageViewModel.favoriteCoins.contains(coin.code)
            })
        }
    }
}
