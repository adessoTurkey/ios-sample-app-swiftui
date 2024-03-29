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
    @EnvironmentObject var router: Router

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
                if screen.type == .detail, let data = screen.data as? CoinUIModel {
                    CoinDetailView(coinData: data)
                }
            }
            .padding(.horizontal, Paddings.side)
            .navigationTitle(Text("Favorites"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: createTopBar)
        }
        .background(Color(.lightestGray))
        .onAppear(perform: viewModel.fetchFavorites)
        .onDisappear(perform: viewModel.disconnect)
        .onChange(of: searchTerm, perform: { newValue in
            viewModel.filterResults(searchTerm: newValue)
            viewModel.sortOptions(sort: viewModel.selectedSortOption)
        })
        .onChange(of: StorageManager.shared.favoriteCoins, perform: { newValue in
            fetchFavorites(codes: newValue)
        })
        .onChange(of: viewModel.selectedSortOption, perform: { new in
            viewModel.sortOptions(sort: new)
        })
    }

    private func fetchFavorites(codes: [CoinUIModel]) {
        viewModel.fetchFavorites()
    }

    @ToolbarContentBuilder
    func createTopBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Image(systemName: Images.favorites)
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(Router())
}
