//
//  Router.swift
//  SampleAppSwiftUI
//
//  Created by Marifet, Oguz on 11.05.2023.
//

import Foundation
import SwiftUI

final public class Router: ObservableObject {
    @Published var homeNavigationPath: [Screen] = []
    @Published var favoritesNavigationPath: [Screen] = []
    @Published var settingsNavigationPath: [Screen] = []
    @Published var selectedTab: TabIndex = .home
    var tabbarNames: [TabIndex] = [.home, .favorites, .settings]
  
    func navigateCoinDetail(coinData: CoinData) {
        if selectedTab == .home {
            homeNavigationPath.append(Screen(type: .detail, data: coinData))
        } else if selectedTab == .favorites {
            favoritesNavigationPath.append(Screen(type: .detail, data: coinData))
        }
    }
}

public enum TabIndex: String {
    case home
    case favorites
    case settings
    func imageName() -> String {
        switch self {
            case .home:
                return "house.fill"
            case .favorites:
                return "star"
            case .settings:
                return "gear"
        }
    }
}

extension Router {
    func onOpenURL(_ url: URL) {
        if let screenType = url.screenType {
            if selectedTab == .home && screenType == .detail {
                // TODO: parse data from deeplink url's query parameters and pass it to Screen
                homeNavigationPath = [Screen(type: screenType, data: nil)]
                return
            }

            if selectedTab == .favorites && screenType == .detail {
                favoritesNavigationPath = [Screen(type: screenType, data: nil)]
            }
        }
    }
}
