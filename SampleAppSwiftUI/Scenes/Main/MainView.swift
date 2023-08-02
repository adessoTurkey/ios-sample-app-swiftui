//
//  MainView.swift
//  boilerplate-ios-swiftui
//
//  Created by Cagri Gider on 14.08.2022.
//  Copyright © 2022 Adesso Turkey. All rights reserved.
//

import PreviewSnapshots
import SwiftUI

struct MainView: View {
    @StateObject private var storageManager = StorageManager.shared
    @EnvironmentObject private var router: Router
    var body: some View {
        TabView(selection: $router.selectedTab) {
            HomeView()
                .tag(TabIndex.home)
                .tabItem {
                    Image(systemName: TabIndex.home.imageName())
                        .accessibilityIdentifier("homeTabView")
                }
            FavoritesView()
                .tag(TabIndex.favorites)
                .tabItem {
                    Image(systemName: TabIndex.favorites.imageName())
                        .accessibilityIdentifier("favoriteTabView")
                }
            SettingsView()
                .tag(TabIndex.settings)
                .tabItem {
                    Image(systemName: TabIndex.settings.imageName())
                        .accessibilityIdentifier("settingsTabView")
                }
        }
        .tint(.blue)
        .shadow(radius: Spacings.default)
    }
}

struct MainView_Previews: PreviewProvider {
    private static let router = Router()
    static var previews: some View {
        snapshots.previews
    }

    static var snapshots: PreviewSnapshots<Void?> {
        .init(configurations: [
            .init(name: "Main View", state: .none)
        ]) { _ in
            MainView()
                .environmentObject(router)
        }
    }
}
