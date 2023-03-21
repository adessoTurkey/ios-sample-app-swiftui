//
//  FavoritesView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 16.03.2023.
//

import SwiftUI

struct FavoritesView: View {

    @State private var searchTerm = ""
    @State private var coins: [CoinInfo] = [.demo, .secondDemo, .demo, .secondDemo, .demo]
    @State private var filteredCoins: [CoinInfo] = []
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchTerm)
                    .padding(.top, 20)
                    .padding(.bottom, 18)
                coinListView()
                Spacer()
            }
            .navigationTitle(Text("Favorites"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: createTopBar)
        }
        .background(Color.lightGray)
        .task {
            viewModel.startSocketConnection()
        }
        .onAppear(perform: fillCoins)
        .onChange(of: searchTerm, perform: filterResults(word:))
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

    @ToolbarContentBuilder
    func createTopBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Image(systemName: "star.fill")
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
