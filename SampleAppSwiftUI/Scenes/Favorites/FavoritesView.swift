//
//  FavoritesView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 16.03.2023.
//

import SwiftUI

struct FavoritesView: View {

    @State private var searchTerm = ""
    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchTerm)
                    .padding(.top, 20)
                    .padding(.bottom, 18)
                coinListView()
                Spacer()
            }
            .padding([.leading, .trailing], 16)
            .navigationTitle(Text("Favorites"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: createTopBar)
        }
        .background(Color.lightGray)
        .onAppear { viewModel.prepareFavoritedCoins() }
        .onChange(of: searchTerm, perform: viewModel.filterResults(searchTerm:))
    }

    @ViewBuilder
    func coinListView() -> some View {
        if viewModel.filteredCoins.isEmpty {
            VStack {
                Spacer(minLength: 200)
                Text("No Coins found.")
                    .bold()
                Spacer()
            }
        } else {
            ForEach(viewModel.filteredCoins) { coin in
                NavigationLink(destination: CoinDetailView()) {
                    CoinView(coinInfo: coin)
                        .tint(Color(uiColor: .label))
                }
            }.animation(.easeInOut, value: viewModel.filteredCoins)
        }
    }

    @ToolbarContentBuilder
    func createTopBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Image(systemName: "star.fill")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
