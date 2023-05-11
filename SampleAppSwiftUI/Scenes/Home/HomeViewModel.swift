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
    @Published var filterTitle = "Most Popular"
    
    func fillModels(demo: Bool = false) async {
        if demo {
            fetchDemoModel()
        }
        await fetchAllCoins()
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
            }
        }
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
        self.coinList = coinList
        self.filteredCoins = coinList
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
