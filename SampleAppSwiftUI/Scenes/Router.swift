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

    func navigateCoinDetail() {
        if selectedTab == .home {
            homeNavigationPath.append(Screen.detail)
        } else if selectedTab == .favorites {
            favoritesNavigationPath.append(Screen.detail)
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
        if let screen = url.screenType {
            if selectedTab == .home && screen == .detail {
                homeNavigationPath = [Screen.detail]
                return
            }
            if selectedTab == .favorites && screen == .detail {
                favoritesNavigationPath = [Screen.detail]
            }
        }
    }
}
