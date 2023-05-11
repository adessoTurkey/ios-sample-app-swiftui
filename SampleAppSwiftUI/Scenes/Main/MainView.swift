//
//  MainView.swift
//  boilerplate-ios-swiftui
//
//  Created by Cagri Gider on 14.08.2022.
//  Copyright © 2022 Adesso Turkey. All rights reserved.
//

import SwiftUI

struct MainView: View {

    @StateObject private var storageManager = StorageManager.shared

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            FavoritesView()
                .tabItem {
                    Image(systemName: "star")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
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
