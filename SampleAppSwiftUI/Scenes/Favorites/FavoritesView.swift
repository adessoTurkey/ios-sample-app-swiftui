//
//  FavoritesView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 16.03.2023.
//

import PreviewSnapshots
import SwiftUI

struct FavoritesView: View {
    @State private var searchTerm = ""
    @StateObject private var viewModel = FavoritesViewModel()
    @EnvironmentObject private var router: Router
    var body: some View {
        NavigationStack(path: $router.favoritesNavigationPath) {
            VStack(spacing: Spacings.favorites) {
                SearchBarView(searchText: $searchTerm, topPadding: Paddings.SearchBar.shortTop)
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
        .onChange(of: searchTerm, perform: viewModel.filterResults(searchTerm:))
        .onChange(of: StorageManager.shared.favoriteCoins, perform: fetchFavorites)
    }

    private func fetchFavorites(codes: [CoinData]) {
        viewModel.fetchFavorites()
    }

    @ToolbarContentBuilder
    func createTopBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Image(systemName: Images.favorites)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static private let router = Router()

    static var previews: some View {
        snapshot.previews
    }

    static var snapshot: PreviewSnapshots<Void?> {
        .init(configurations: [
            .init(name: "Favorites  View", state: nil)
        ], configure: { _ in
            FavoritesView()
                .environmentObject(router)
        })
    }
}
