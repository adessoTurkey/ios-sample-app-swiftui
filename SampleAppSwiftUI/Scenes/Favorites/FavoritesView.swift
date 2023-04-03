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
                SearchBarView(searchText: $searchTerm, topPadding: Paddings.SearchBar.shortTop)
                CoinListView(filteredCoins: viewModel.filteredCoins)
                Spacer()
            }
            .sidePadding(size: Paddings.side)
            .navigationTitle(Text("Favorites"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: createTopBar)
        }
        .background(Color.lightGray)
        .onAppear { viewModel.prepareFavoritedCoins() }
        .onChange(of: searchTerm, perform: viewModel.filterResults(searchTerm:))
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
