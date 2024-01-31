//
//  Router.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 29.12.2023.
//

import SwiftUI

enum RouteDestination: Hashable {
    case coinDetail(coin: CoinUIModel)
    case coinList(list: [CoinUIModel])

    public static func == (lhs: RouteDestination, rhs: RouteDestination) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

final class Router: ObservableObject {
    @Published var path: [RouteDestination] = []

    public init() {}

    func navigate(to route: RouteDestination) {
        path.append(route)
    }

    func navigateToRoot() {
        path.removeAll()
    }
}

extension Router {
    func onOpenURL(_ url: URL) {}
}

@MainActor
extension View {
    func withAppRouter() -> some View {
        navigationDestination(for: RouteDestination.self) { route in
            switch route {
            case .coinDetail(let coin):
                CoinDetailView(coin: coin)
            case .coinList(let list):
                CoinVerticalListView(coins: list)
            default:
                EmptyView()
            }
        }
    }
}
