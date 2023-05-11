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

    private var webSocketService: any WebSocketServiceProtocol
    private var cancellable = Set<AnyCancellable>()
    private var reconnectionCount: Int = 0
    private var maxReconnectionCount: Int = 3

    @Published var coinInfo: CoinData?
    @Published var coinList: [CoinData] = []
    @Published var filterTitle = "Most Popular"

    init(webSocketService: any WebSocketServiceProtocol = WebSocketService.shared) {
        self.webSocketService = webSocketService
    }

    func startSocketConnection() {
        reconnectionCount = 0
//        connect()
    }

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

    func disconnect() {
        webSocketService.disconnect()
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
