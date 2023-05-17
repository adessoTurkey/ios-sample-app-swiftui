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
            ScrollView {
                VStack {
                    SearchBarView(searchText: $searchTerm, topPadding: Paddings.SearchBar.shortTop)
                    CoinListView(filteredCoins: $viewModel.filteredCoins, favoriteChanged: viewModel.fetchFavorites)
                    Spacer()
                }
                .sidePadding(size: Paddings.side)
                .navigationTitle(Text("Favorites"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: createTopBar)
            }
        }
        .background(Color.lightGray)
        .onAppear(perform: viewModel.fetchFavorites)
        .onDisappear(perform: viewModel.disconnect)
        .onChange(of: searchTerm, perform: viewModel.filterResults(searchTerm:))
        .onChange(of: StorageManager.shared.favoriteCoins) { _ in
            viewModel.fetchFavorites()
        }
    }

    @ToolbarContentBuilder
    func createTopBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Image(systemName: Images.favorites)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
