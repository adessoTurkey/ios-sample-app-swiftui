//
//  MainView.swift
//  boilerplate-ios-swiftui
//
//  Created by Cagri Gider on 14.08.2022.
//  Copyright © 2022 Adesso Turkey. All rights reserved.
//

import SwiftUI

struct MainView: View {

    @State private var storageManager = StorageManager.shared
    @Binding var router: Router

    var body: some View {
        TabView(selection: $router.selectedTab) {
            HomeView(router: $router)
                .tag(TabIndex.home)
                .tabItem {
                    Image(systemName: TabIndex.home.imageName())
                        .accessibilityIdentifier("homeTabView")
                }
            FavoritesView(router: $router)
                .tag(TabIndex.favorites)
                .tabItem {
                    Image(systemName: TabIndex.favorites.imageName())
                        .accessibilityIdentifier("favoriteTabView")
                }
            SettingsView(router: $router)
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

#Preview {
    MainView(router: .constant(Router()))
}
