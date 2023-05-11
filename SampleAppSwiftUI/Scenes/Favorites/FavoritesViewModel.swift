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

    @Published var coinInfo: CoinData?
    @Published var coinList: [CoinData] = []
    @Published var filterTitle = "Most Popular"

    func fetchFavorites() {
        Task {
            await fetchAllCoins()
        }
    }

    private func fetchAllCoins() async {
        guard let dataSource = try? await AllCoinRemoteDataSource().getAllCoin(limit: 30, unitToBeConverted: "USD", page: 1) else {
            print("Problem on the convert")
            return
        }
        DispatchQueue.main.async {
            if let data = dataSource.data {
                self.coinList = data
                self.filteredCoins = data
                self.getFavoriteCoinList()
            }
        }
    }

    private func getFavoriteCoinList() {
        if StorageManager.shared.favoriteCoins.isEmpty {
            filteredCoins.removeAll()
        } else {
            filteredCoins = coinList.filter({ coin in
                if let info = coin.coinInfo,
                   let code = info.code {
                    return StorageManager.shared.isCoinFavorite(code: code)
                } else {
                    return false
                }
            })
            print(coins)
            print(filteredCoins)
        }
    }

    private func fetchModelDetails() {
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
        guard let coinList = JsonHelper.make([CoinInfo].self, .coinList) else { return }
        self.fillDemoData(coinList: coinList)
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
