//
//  HomeView.swift
//  boilerplate-ios-swiftui
//
//  Created by Cagri Gider on 14.08.2022.
//  Copyright © 2022 Adesso Turkey. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    @State private var searchTerm = ""
    @EnvironmentObject var router: Router
    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn

    var stack: some View {
        VStack(spacing: Spacings.home) {
            SearchBarView(searchText: $searchTerm, topPadding: Paddings.SearchBar.shortTop)
            FilterView(viewModel: viewModel)
                .padding(.bottom, Paddings.filterBottom)
            Divider()
            CoinListView(viewModel: viewModel, filteredCoins: $viewModel.filteredCoins) {
                Task {
                    await viewModel.fillModels()
                }
            }
        }
        .padding(.horizontal, Paddings.side)
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.lightestGray))
        .onAppear {
            Task {
                await viewModel.fillModels()
            }
        }
        .onChange(of: searchTerm, perform: { newValue in
            viewModel.filterResults(searchTerm: newValue)
            viewModel.sortOptions(sort: viewModel.selectedSortOption)
        })
        .onChange(of: viewModel.selectedSortOption, perform: { newValue in
            viewModel.sortOptions(sort: newValue)
        })
    }

    var body: some View {
        if UIDevice.current.userInterfaceIdiom != .pad {
            NavigationStack(path: $router.homeNavigationPath) {
                stack
                    .ignoresSafeArea(.all, edges: [.top, .trailing, .leading])
                    .navigationDestination(for: Screen.self) { screen in
                        if screen.type == .detail, let data = screen.data as? CoinData {
                            CoinDetailView(coinData: data)
                        }
                    }
            }
        } else {
            NavigationSplitView(columnVisibility: $columnVisibility) {
                stack
            } detail: {
                if let screen = router.homeNavigationPath.last(where: { screen in
                    screen.type == .detail
                }) {
                    if let data = screen.data as? CoinData {
                        NavigationStack {
                            CoinDetailView(coinData: data)
                                .id(UUID())
                        }
                    }
                }
            }
            .navigationSplitViewStyle(.balanced)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())
}
