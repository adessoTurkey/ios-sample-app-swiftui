//
//  HomeView.swift
//  boilerplate-ios-swiftui
//
//  Created by Cagri Gider on 14.08.2022.
//  Copyright © 2022 Adesso Turkey. All rights reserved.
//

import SwiftUI
import PulseUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    @State private var filterTitle = "Most Popular"
    @State private var searchTerm = ""
    @State private var coins: [CoinInfo] = [.demo, .secondDemo, .demo, .secondDemo, .demo]
    @State private var filteredCoins: [CoinInfo] = []

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    SearchBarView(searchText: $searchTerm)
                        .padding(.top, 76)
                        .padding(.bottom, 18)
                    filterView
                        .padding(.bottom, 12)
                    coinListView()
                }
                .padding([.leading, .trailing], 16)
            }
            .ignoresSafeArea(.all, edges: .top)
        }
        .background(Color.lightGray)
        .ignoresSafeArea(.all, edges: [.top, .trailing, .leading])
        .task {
            viewModel.startSocketConnection()
        }
        .onAppear(perform: fillCoins)
        .onChange(of: searchTerm, perform: filterResults(word:))
    }

    var filterView: some View {
        HStack {
            Text(filterTitle)
            Spacer()
            Image(systemName: "slider.horizontal.3")
        }
    }

    @ViewBuilder
    func coinListView() -> some View {
        if filteredCoins.isEmpty {
            VStack {
                Spacer(minLength: 200)
                Text("No Coins found.")
                    .bold()
                Spacer()
            }
        } else {
            ForEach(filteredCoins) { coin in
                NavigationLink(destination: CoinDetailView()) {
                    CoinView(coinInfo: coin)
                        .tint(Color(uiColor: .label))
                }
            }.animation(.easeInOut, value: filteredCoins)
        }
    }

    func filterResults(word: String) {
        if !searchTerm.isEmpty {
            filteredCoins = coins.filter { coin in
                coin.title.lowercased().contains(searchTerm.lowercased()) || coin.code.lowercased().contains(searchTerm.lowercased())
            }
        } else {
            filteredCoins = coins
        }
    }

    func fillCoins() {
        filteredCoins = coins
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
