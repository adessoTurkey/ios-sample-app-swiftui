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
    @EnvironmentObject private var router: Router
    
    var body: some View {
        NavigationStack(path: $router.favoritesNavigationPath) {
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
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                case .detail:
                    CoinDetailView()
                }
            }
        }
        .background(Color.lightGray)
        .onAppear(perform: viewModel.fetchFavorites)
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
