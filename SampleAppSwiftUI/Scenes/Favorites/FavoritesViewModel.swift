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
    @Published var filteredCoins: [CoinInfo] = []
    @Published var favoritedCoins: [CoinInfo] = []

    init() {
        prepareFavoritedCoins()
    }

    func prepareFavoritedCoins() {
        if let data = UserDefaults.standard.data(forKey: "favoriteList") {
            if let favoriteList = try? PropertyListDecoder().decode([CoinInfo].self, from: data) {
                self.favoritedCoins = favoriteList
                filterResults(searchTerm: "")
            }
        }
    }

    func filterResults(searchTerm: String) {
        if !searchTerm.isEmpty {
            filteredCoins = favoritedCoins.filter { coin in
                coin.title.lowercased().contains(searchTerm.lowercased()) || coin.code.lowercased().contains(searchTerm.lowercased())
            }
        } else {
            filteredCoins = favoritedCoins
        }
    }
}
