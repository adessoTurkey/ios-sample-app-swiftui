//
//  HomeViewType.swift
//  SampleWatchAppSwiftUI
//
//  Created by Yildirim, Alper on 7.11.2023.
//

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
