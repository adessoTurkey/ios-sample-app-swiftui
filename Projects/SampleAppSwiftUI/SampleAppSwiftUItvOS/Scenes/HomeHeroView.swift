//
//  HomeHeroView.swift
//  SampleAppSwiftUItvOS
//
//  Created by Yildirim, Alper on 12.01.2024.
//

import SwiftUI

struct HomeHeroView: View {
    var body: some View {
        TabView {
            CoinDetailView(coin: .demo)
                .tabItem {
                    Label("Sent", systemImage: "tray.and.arrow.up.fill")
                }
            CoinDetailView(coin: .demo)
                .tabItem {
                    Label("Sent", systemImage: "tray.and.arrow.up.fill")
                }
            CoinDetailView(coin: .demo)
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    HomeHeroView()
}
