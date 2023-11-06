//
//  HomeViewModel.swift
//  SampleWatchAppSwiftUI
//
//  Created by Yildirim, Alper on 17.10.2023.
//

import Foundation
import SwiftUI
import WatchConnectivity

class HomeViewModel: NSObject, ObservableObject {
    @Published var coinList: [CoinData] = []
    @Published var pageState: PageState = .idle
    @Published var homeViewType: HomeViewType = .topCoins

    var favoriteCoins: [CoinData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.coinList = self.favoriteCoins
            }
        }
    }

    var watchSession = WCSession.default
    private let listPageLimit = 10
    private let userDefaults = UserDefaults.standard

    override init() {
        super.init()
        initWatchConnectivity()
    }

    func checkLastItem(_ item: CoinData) {
        guard pageState != .loading, homeViewType == .topCoins else { return }

        let offset = 2
        let index = coinList.count - 1 - offset
        guard index > 0 else { return }
        let lastItemID = coinList[index].id

        if item.id == lastItemID {
            updatePageState(with: .fetching)
            Task {
                await fetchAllCoins(page: getCurrentPage())
            }
        }
    }

    func getCurrentPage() -> Int {
        (coinList.count / listPageLimit) + 1
    }

    func fetchScreen() async {
        switch homeViewType {
            case .topCoins:
                await fetchAllCoins()
            case .favorites:
                getFavoriteCoins()
        }
    }

    func toggleViewType() async {
        homeViewType = homeViewType == .topCoins
        ? .favorites
        : .topCoins
        await fetchScreen()
    }

    func getFavoriteCoins() {
        updatePageState(with: .fetching)
        getStoredFavorites()
        updatePageState(with: .finished)
    }

    func updateFavoriteCoins(with coins: [CoinData]) {
        updatePageState(with: .fetching)
        favoriteCoins = coins
        storeFavorites()
        updatePageState(with: .finished)
    }

    private func fetchAllCoins(page: Int = 1) async {
        updatePageState(with: .fetching)
        guard
            let dataSource = try? await AllCoinRemoteDataSource().getAllCoin(limit: self.listPageLimit, unitToBeConverted: "USD", page: page),
            let coinList = dataSource.data
        else {
            print("There has been a problem while converting unit of: USD")
            updatePageState(with: .error)
            return
        }

        DispatchQueue.main.async {
            self.coinList.append(contentsOf: coinList)
            self.pageState = .finished
        }
    }

    private func updatePageState(with state: PageState) {
        DispatchQueue.main.async {
            self.pageState = state
        }
    }

    private func storeFavorites() {
        guard let data: Data = favoriteCoins.encode() else { return }
        userDefaults.set(data, forKey: "favoriteCoins")
    }

    private func getStoredFavorites() {
        guard
            let favoritesData = userDefaults.data(forKey: "favoriteCoins"),
            let favoritesModel = [CoinData].decode(favoritesData)
        else {
            return
        }
        favoriteCoins = favoritesModel
        if favoriteCoins.isEmpty {
            updatePageState(with: .empty)
        }
    }
}

extension HomeViewModel: WCSessionDelegate {
    func initWatchConnectivity() {
        if watchSession.activationState == .notActivated {
            watchSession.delegate = self
            watchSession.activate()
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationState: \(activationState)")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        guard
            let data = message["favoriteCoinsData"] as? Data,
            let favoriteCoins = [CoinData].decode(data)
        else {
            return
        }
        updateFavoriteCoins(with: favoriteCoins)
        replyHandler(message)
    }
}
