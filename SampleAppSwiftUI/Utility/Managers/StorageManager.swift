//
//  StorageManager.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 4.04.2023.
//

import SwiftUI

class StorageManager: ObservableObject {

    static let shared = StorageManager()

    @AppStorage("favoriteCoins") var favoriteCoins: [String] = [] {
        didSet {
            objectWillChange.send()
        }
    }

    func isCoinFavorite(code: String) -> Bool {
        favoriteCoins.contains(code)
    }

    func checkFavorite(code: String) {
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

    private func addFavoriteCoin(code: String) {
        DispatchQueue.main.async {
            self.favoriteCoins.append(code)
        }
    }

    private func removeFavoriteCoin(code: String) {
        DispatchQueue.main.async {
            self.favoriteCoins.removeAll(where: { $0 == code })
        }
    }

    func manageFavorites(code: String) -> String {
        let output = isCoinFavorite(code: code) ? "Removed from Favorites" : "Added to Favorites"
        checkFavorite(code: code)
        return output
    }

}
