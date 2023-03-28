//
//  CoinViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 23.03.2023.
//

import SwiftUI

class CoinInfoViewModel: ObservableObject {
    func createPriceString(coinInfo: CoinInfo) -> String {
        coinInfo.price.formatted(.currency(code: "USD").precision(.fractionLength(2...4)))
    }

    func getURL(from code: String) -> URL? {
        URL(string: "https://cryptoicons.org/api/icon/\(code.lowercased())/40")
    }

    func createChangeText(coinInfo: CoinInfo) -> String {
        """
\((coinInfo.changePercentage / 100)
.formatted(.percent)) (\(coinInfo.changeAmount
.formatted(.currency(code: "USD")
.precision(.fractionLength(2...4)))))
"""
    }

    func manageFavorites(coinInfo: CoinInfo) -> String {
        if let data = UserDefaults.standard.data(forKey: "favoriteList") {
            var favoriteList = (try? PropertyListDecoder().decode([CoinInfo].self, from: data)) ?? [CoinInfo]()

            let index = favoriteList.firstIndex(of: coinInfo)
            if let index { // if its index can be found, it is also exist. So, it should be deleted.
                favoriteList.remove(at: index)
                if let data = try? PropertyListEncoder().encode(favoriteList) {
                    UserDefaults.standard.set(data, forKey: "favoriteList")
                    return "Removed from Favorites"
                }
            } else {
                favoriteList.append(coinInfo)
                if let data = try? PropertyListEncoder().encode(favoriteList) {
                    UserDefaults.standard.set(data, forKey: "favoriteList")
                    return "Added to Favorites"
                }
            }
        }
        return "Couldn't make changes,\nthere is a problem."
    }
}
