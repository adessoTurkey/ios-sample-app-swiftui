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
            VStack(spacing: Spacings.favorites) {
                SearchBarView(searchText: $searchTerm, topPadding: Paddings.SearchBar.shortTop)
                FilterView(viewModel: viewModel)
                    .padding(.bottom, Paddings.filterBottom)
                Divider()
                CoinListView(viewModel: viewModel, filteredCoins: $viewModel.filteredCoins, favoriteChanged: viewModel.fetchFavorites)
            }
            .navigationDestination(for: Screen.self) { screen in
                if screen.type == .detail, let data = screen.data as? CoinData {
                    CoinDetailView(coinData: data)
                }
            }
            .padding(.horizontal, Paddings.side)
            .navigationTitle(Text(Strings.favorites))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: createTopBar)
        }
        .background(Color.lightGray)
        .onAppear(perform: viewModel.fetchFavorites)
        .onDisappear(perform: viewModel.disconnect)
        .onChange(of: searchTerm) { searchTerm in
            viewModel.filterResults(searchTerm: searchTerm)
            viewModel.sortOptions(sort: viewModel.selectedSortOption)
        }
//        .onChange(of: CoreDataManager.shared.getCoins(), perform: fetchFavorites)
        .onChange(of: viewModel.selectedSortOption, perform: viewModel.sortOptions(sort:))
    }

//    private func fetchFavorites(codes: [CoinData]) {
//        viewModel.fetchFavorites()
//    }

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
