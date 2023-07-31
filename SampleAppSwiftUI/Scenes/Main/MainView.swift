//
//  MainView.swift
//  boilerplate-ios-swiftui
//
//  Created by Cagri Gider on 14.08.2022.
//  Copyright © 2022 Adesso Turkey. All rights reserved.
//

import SwiftUI

struct MainView: View {

    @StateObject private var storageManager = CoreDataManager.shared
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
    static var previews: some View {
        MainView()
    }
}
