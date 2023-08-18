//
//  HomeView.swift
//  boilerplate-ios-swiftui
//
//  Created by Cagri Gider on 14.08.2022.
//  Copyright © 2022 Adesso Turkey. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    @State private var viewModel = HomeViewModel()
    @State private var searchTerm = ""
    @Binding var router: Router

    var body: some View {
        NavigationStack(path: $router.homeNavigationPath) {
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
            }.padding(.horizontal, Paddings.side)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Screen.self) { screen in
                if screen.type == .detail, let data = screen.data as? CoinData {
                    CoinDetailView(coinData: data)
                }
            }
        }
        .background(Color(.lightestGray))
        .ignoresSafeArea(.all, edges: [.top, .trailing, .leading])
        .onAppear {
            Task {
                await viewModel.fillModels()
            }
        }
        .onChange(of: searchTerm, { _, newValue in
            viewModel.filterResults(searchTerm: newValue)
            viewModel.sortOptions(sort: viewModel.selectedSortOption)
        })
        .onChange(of: viewModel.selectedSortOption, { _, newValue in
            viewModel.sortOptions(sort: newValue)
        })
    }
}

#Preview {
    HomeView(router: .constant(.init()))
}
