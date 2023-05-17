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
        startSocketConnection()
    }
    
    deinit {
        self.disconnect()
        print("Ended Socket")
    }

    func startSocketConnection() {
        reconnectionCount = 0
        disconnect()
        connect()
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
            self.startSocketConnection()
        }
    }
    
    func disconnect() {
        webSocketService.disconnect()
        print("FavoritesViewModel.webSocketService.disconnect")
    }

    private func connect() {
        guard reconnectionCount < maxReconnectionCount,
             let service = webSocketService.connect(endPoint: .baseCoinApi) else {
            print("Service connection error.", terminator: "\n*******\n")
            return
        }
        service.setPing(time: 10)
        service.connectionHandler {[weak self] webservice in
            guard let self else { return }
            var subs: [String] = []
            for coin in self.filteredCoins {
                if let coinInfo = coin.coinInfo,
                   let code = coinInfo.code {
                    subs.append("5~CCCAGG~\(code)~USD")
                }
            }
            let request = FavoritesCoinRequest(action: SubscriptionRequestAction.add.rawValue, subs: subs)
            webservice.sendMessage(request)
        } disconnected: { [weak self] closeCode in
            guard let self,
                  closeCode != .goingAway else { return }
            self.reconnectionCount += 1
            self.connect()
        }.receive(on: DispatchQueue.main)
        .sink { _ in }
        receiveValue: { [weak self] socketData in
            guard let self else { return }
            self.webSocketDidReceiveMessage(socketData)
        }.store(in: &cancellable)
    }
    
    private func webSocketDidReceiveMessage(_ socketResponse: URLSessionWebSocketTask.Message) {
        if let coin: FavoritesCoinResponse = socketResponse.convert() {
            if let favoriteIndex = self.filteredCoins.firstIndex(where: { $0.coinInfo?.code == coin.code }) {
                if let oldPrice = coin.lowestToday,
                   let newPrice = coin.price {
                    var newCoin = self.filteredCoins[favoriteIndex]
                    newCoin.detail?.usd?.changePercentage = oldPrice / newPrice * 100
                    newCoin.detail?.usd?.changeAmount = newPrice - oldPrice
                    newCoin.detail?.usd?.price = newPrice
                    if true {
                        let title = newCoin.coinInfo?.title ?? ""
                        newCoin.coinInfo?.title =  "\(title)+"
                    }
                    self.filteredCoins[favoriteIndex] = newCoin
                }
            }
        } else {
            print("!Parse Error", socketResponse,
                  separator: "\n", terminator: "\n---|||---\n")
        }
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
