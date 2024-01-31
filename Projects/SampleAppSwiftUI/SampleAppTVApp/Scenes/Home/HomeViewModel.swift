//
//  HomeViewModel.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 28.12.2023.
//

import Foundation
import NetworkService

enum HomeListType: Int, CaseIterable {
    case topCoins
    case topByDailyVolume
    case recentlyVisited
    case favorites

    func getTitle() -> String {
        switch self {
        case .topCoins:
            "Top Coins"
        case .topByDailyVolume:
            "Top Volume in 24H"
        case .recentlyVisited:
            "Recently Visited"
        case .favorites:
            "Favorites"
        }
    }
}

class HomeViewModel: NSObject, ObservableObject {
    @Published var allCoins: [CoinUIModel] = []
    @Published var topVolumeCoins: [CoinUIModel] = []
    @Published var recentlyVisited: [CoinUIModel] = []
    @Published var favoriteCoins: [CoinUIModel] = []
    var listStates: [HomeListType: PageState] = [:]

    private let allCoinsUseCase: AllCoinUseCaseProtocol = AllCoinUseCase()
    private let favoriteCoinsManager = FavoriteCoinsManager()
    private let recentlyVisitedManager = VisitedCoinsManager()

    private let listPageLimit = 20
    private let userDefaults = UserDefaults.standard

    override init() {
        super.init()
    }

    func fetchData(type: HomeListType) async {
        switch type {
        case .topCoins:
            await fetchAllCoins()
        case .topByDailyVolume:
            await fetchTopVolume()
        case .recentlyVisited:
            getRecentlyVisited()
        case .favorites:
            getFavorites()
        }
    }

    private func fetchTopVolume() async {
        updatePageState(with: .fetching, listType: .topByDailyVolume)
        guard
            let dataSource = try? await allCoinsUseCase.fetchTopVolume(limit: listPageLimit,
                                                                       unitToBeConverted: "USD", page: 1),
            let coinList = dataSource.data
        else {
            print("There has been a problem while converting unit of: USD")
            updatePageState(with: .error, listType: .topByDailyVolume)
            return
        }

        DispatchQueue.main.async {
            self.topVolumeCoins.append(contentsOf: coinList)
            self.updatePageState(with: .finished, listType: .topByDailyVolume)
        }
    }

    private func fetchAllCoins() async {
        updatePageState(with: .fetching, listType: .topCoins)
        guard
            let dataSource = try? await allCoinsUseCase.fetchAllCoin(limit: listPageLimit,
                                                                     unitToBeConverted: "USD", page: 1),
            let coinList = dataSource.data
        else {
            print("There has been a problem while converting unit of: USD")
            updatePageState(with: .error, listType: .topCoins)
            return
        }

        DispatchQueue.main.async {
            self.allCoins = coinList
            self.updatePageState(with: .finished, listType: .topCoins)
        }
    }

    private func getRecentlyVisited() {
        DispatchQueue.main.async { [self] in
            recentlyVisited = recentlyVisitedManager.getRecentlyVisitedCoins()
            updatePageState(with: .finished, listType: .recentlyVisited)
        }
    }

    private func getFavorites() {
        DispatchQueue.main.async { [self] in
            favoriteCoins = favoriteCoinsManager.getFavoriteCoins()
            updatePageState(with: .finished, listType: .favorites)
        }
    }

    func addCoinToRecentlyVisited(_ coin: CoinUIModel) {
        recentlyVisitedManager.addRecentlyVisitedCoin(coin)
    }

    private func updatePageState(with state: PageState, listType: HomeListType) {}
}
