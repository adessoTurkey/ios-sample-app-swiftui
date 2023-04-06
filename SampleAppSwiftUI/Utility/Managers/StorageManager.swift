//
//  StorageManager.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 4.04.2023.
//

import SwiftUI

final class StorageManager: ObservableObject {

    static let shared = StorageManager()

    @AppStorage("favoriteCoins") var favoriteCoins: [CoinCode] = [] {
        didSet {
            objectWillChange.send()
        }
    }

    private init() { }

    func isCoinFavorite(code: CoinCode) -> Bool {
        favoriteCoins.contains(code)
    }

    func toggleFavoriteCoin(code: CoinCode) {
        if favoriteCoins.isEmpty {
            addFavoriteCoin(code: code)
        } else {
            if isCoinFavorite(code: code) {
                removeFavoriteCoin(code: code)
            } else {
                addFavoriteCoin(code: code)
            }
        }
    }

    private func addFavoriteCoin(code: CoinCode) {
        DispatchQueue.main.async {
            self.favoriteCoins.append(code)
        }
    }

    private func removeFavoriteCoin(code: CoinCode) {
        DispatchQueue.main.async {
            self.favoriteCoins.removeAll(where: { $0 == code })
        }
    }

    func manageFavorites(code: CoinCode) -> String {
        let output = isCoinFavorite(code: code) ? "Removed from Favorites" : "Added to Favorites"
        toggleFavoriteCoin(code: code)
        return output
    }

}
