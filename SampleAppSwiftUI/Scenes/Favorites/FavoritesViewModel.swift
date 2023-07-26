//
//  FavoritesViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 27.03.2023.
//

import Foundation
import SwiftUI
import Combine
import Observation

class FavoritesViewModel {
    var coins: [CoinData] = []
    var filteredCoins: [CoinData] = []

    private var webSocketService: any WebSocketServiceProtocol
    private var cancellable = Set<AnyCancellable>()
    private var reconnectionCount: Int = 0
    private var maxReconnectionCount: Int = 3
    private let checkWebSocket = true

    var coinInfo: CoinData?
    var filterTitle = "Most Popular"

    let listPageLimit = 10
    @State var isLoading: Bool = false

    init(webSocketService: any WebSocketServiceProtocol = WebSocketService.shared) {
        self.webSocketService = webSocketService
    }

    deinit {
        self.disconnect()
    }

    func startSocketConnection() {
        reconnectionCount = 0
        disconnect()
        connect()
    }

    func fetchFavorites() {
        DispatchQueue.main.async {
            self.isLoading = false
            self.getFavoriteCoinList()
            self.startSocketConnection()
        }
    }

    private func getFavoriteCoinList() {
        coins = StorageManager.shared.favoriteCoins
        filteredCoins = coins
    }

    func disconnect() {
        webSocketService.disconnect()
    }

    private func connect() {
        guard reconnectionCount < maxReconnectionCount,
             let service = webSocketService.connect(endPoint: .baseCoinApi) else {
            NSLog("Service connection error.")
            return
        }
        service.setPing(time: 10)
        service.connectionHandler {[weak self] webservice in
            guard let self else { return }
            var subs: [CoinCode] = []
            for coin in self.filteredCoins {
                if let coinInfo = coin.coinInfo,
                   let code = coinInfo.code {
                    subs.append(code)
                }
            }
            let request = FavoritesCoinRequest(action: .add, codeList: subs)
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
        guard let coin: FavoritesCoinResponse = socketResponse.convert() else {
            NSLog("Parse Error: \n\(socketResponse)")
            return
        }
        if let favoriteIndex = self.filteredCoins.firstIndex(where: { $0.coinInfo?.code == coin.code }),
           let oldPrice = coin.lowestToday,
           let newPrice = coin.price {
            var newCoin = self.filteredCoins[favoriteIndex]
            newCoin.detail?.usd?.changePercentage = oldPrice / newPrice
            newCoin.detail?.usd?.changeAmount = newPrice - oldPrice
            newCoin.detail?.usd?.price = newPrice
            if checkWebSocket {
                let title = newCoin.coinInfo?.title ?? ""
                newCoin.coinInfo?.title =  "\(title)+"
            }
            self.filteredCoins[favoriteIndex] = newCoin
        }
    }

    func filterResults(searchTerm: String = "") {
        if !searchTerm.isEmpty {
            filteredCoins = coins.filter { coin in
                if let coinCode = coin.coinInfo?.code {
                    return coin.coinInfo?.title?.lowercased().contains(searchTerm.lowercased()) ?? true ||
                    coin.coinInfo?.code?.lowercased().contains(searchTerm.lowercased())  ?? true &&
                    StorageManager.shared.isCoinFavorite(coinCode)
                } else {
                    return false
                }
            }
        } else {
            filteredCoins = coins.filter({ coin in
                if let coinInfo = coin.coinInfo,
                   let coinCode = coinInfo.code {
                    return StorageManager.shared.isCoinFavorite(coinCode)
                } else {
                    return false
                }
            })
        }
    }
}

extension FavoritesViewModel: ViewModelProtocol {}
