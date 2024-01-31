//
//  HomeViewType.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 28.12.2023.
//

enum HomeViewType {
    case topCoins
    case favorites

    var imageSystemName: String {
        switch self {
        case .topCoins: 
            "list.number"
        case .favorites: 
            "heart"
        }
    }

    var currentPageTitle: String {
        switch self {
        case .topCoins: 
            "Top Coins"
        case .favorites: 
            "Favorites"
        }
    }

    var alternativePageTitle: String {
        self == .favorites
            ? Self.topCoins.currentPageTitle
            : Self.favorites.currentPageTitle
    }
}
