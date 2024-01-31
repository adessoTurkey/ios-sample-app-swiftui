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

    func navigateCoinDetail(coinData: CoinUIModel) {
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
        guard let screenType = url.screenType else { return }

        let parameters = url.queryParameters
        let coinData = createCoinData(from: parameters)
        let screen = Screen(type: screenType, data: coinData)

        switch (selectedTab, screenType) {
        case (.home, .detail):
            homeNavigationPath = [screen]
        case (.favorites, .detail):
            favoritesNavigationPath = [screen]
        default:
            break
        }
    }
    
    private func createCoinData(from parameters: [String: String]) -> CoinUIModel {
        return CoinUIModel(
            id: parameters["id"] ?? "",
            coinInfo: CoinMarketCapsCoinInfoUIModel(
                code: parameters["code"] ?? "",
                title: parameters["title"] ?? ""
            ),
            detail: CoinRawUIModel(
                usd: RawUsdUIModel(
                    price: Double(parameters["price"] ?? "") ?? 0,
                    changeAmount: Double(parameters["changeAmount"] ?? "") ?? 0,
                    changePercentage: Double(parameters["changePercentage"] ?? "") ?? 0
                )
            )
        )
    }
}
