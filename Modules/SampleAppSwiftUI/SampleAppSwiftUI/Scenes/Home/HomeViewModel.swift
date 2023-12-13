//
//  HomeViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 21.02.2023.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var coinInfo: ExcangeRatesResponseModel?
    @Published var coinList: [CoinData] = []
    @Published var filteredCoins: [CoinData] = []
    @Published var filterTitle = SortOptions.defaultList.rawValue

    let listPageLimit = 10
    @Published var isLoading: Bool = false
    @Published var selectedSortOption: SortOptions = .defaultList

    func fillModels(demo: Bool = false) async {
        if demo {
            fetchDemoModel()
        }
        await fetchAllCoins()
    }

    private func fetchAllCoins(page: Int = 1) async {
        guard let dataSource = try? await AllCoinRemoteDataSource().getAllCoin(limit: self.listPageLimit, unitToBeConverted: "USD", page: page) else {
            Logger().error("Problem on the convert")
            return
        }
        DispatchQueue.main.async {
            if let data = dataSource.data {
                self.coinList.append(contentsOf: data)
                self.filteredCoins.append(contentsOf: data)
                self.sortOptions(sort: self.selectedSortOption)
                self.isLoading = false
            }
        }
    }

    func filterResults(searchTerm: String) {
        if !searchTerm.isEmpty {
            filteredCoins = coinList.filter { coin in
                if let coinInfo = coin.coinInfo,
                   let title = coinInfo.title,
                   let code = coinInfo.code {
                    return title.lowercased().contains(searchTerm.lowercased()) ||
                    code.lowercased().contains(searchTerm.lowercased())
                } else {
                    return false
                }
            }
        } else {
            filteredCoins = coinList
        }
    }
}

extension HomeViewModel: ViewModelProtocol {

    func checkLastItem(_ item: CoinData) {
        guard !isLoading else { return }

        let offset = 2
        let index = coinList.count - offset - 1
        guard index > 0 else { return }
        let id = coinList[index].id

        if item.id == id {
            isLoading = true
            Task {
                await fetchAllCoins(page: getCurrentPage())
            }
        }
    }

    func getCurrentPage() -> Int {
        (coinList.count / listPageLimit) + 1
    }
}

// MARK: Demo Mode
extension HomeViewModel {
    private func fetchDemoModel() {
        guard let coinList = JsonHelper.make([CoinData].self, .coinList) else { return }
        self.fillDemoData(coinList: coinList)
    }

    private func fillDemoData(coinList: [CoinData]) {
        self.coinList = coinList
        self.filteredCoins = coinList
    }
}
