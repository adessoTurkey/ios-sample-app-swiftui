//
//  HomeViewModel.swift
//  SampleWatchAppSwiftUI
//
//  Created by Yildirim, Alper on 17.10.2023.
//

import Foundation

enum HomeViewType {
    case topCoins
    case favorites

    var imageSystemName: String {
        switch self {
            case .topCoins:
                return "list.number"
            case .favorites:
                return "heart"
        }
    }

    var currentPageTitle: String {
        switch self {
            case .topCoins:
                return "Top Coins"
            case .favorites:
                return "Favorites"
        }
    }

    var alternativePageTitle: String {
        self == .favorites
        ? Self.topCoins.currentPageTitle
        : Self.favorites.currentPageTitle
    }
}

class HomeViewModel: ObservableObject {
    @Published var coinList: [CoinData] = []
    @Published var pageState: PageState = .idle
    @Published var homeViewType: HomeViewType = .topCoins

    private var favoriteCoins: [CoinData] = []
    private var userDefaults = UserDefaults(suiteName: Configuration.appGroupName)
    private let listPageLimit = 10

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

        guard
            let jsonString = userDefaults?.string(forKey: "favoriteCoins"),
            let data = jsonString.data(using: .utf8),
            let favoriteCoinsDecoded = [CoinData].decode(data)
        else {
            updatePageState(with: .empty)
            return
        }

        coinList = favoriteCoinsDecoded
        pageState = .finished
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
}
