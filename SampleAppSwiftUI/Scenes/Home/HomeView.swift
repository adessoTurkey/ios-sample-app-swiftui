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

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Spacings.home) {
                    SearchBarView(searchText: $searchTerm, topPadding: Paddings.SearchBar.largeTop)
                    HomeFilterView(filterTitle: viewModel.filterTitle)
                        .padding(.bottom, Paddings.filterBottom)
                    CoinListView(filteredCoins: viewModel.filteredCoins) {
                        viewModel.fillModels(demo: true)
}
                }
                .sidePadding(size: Paddings.side)
            }
            .ignoresSafeArea(.all, edges: .top)
        }
        .background(Color.lightGray)
        .ignoresSafeArea(.all, edges: [.top, .trailing, .leading])
        // .task { viewModel.startSocketConnection() }
        .onAppear { viewModel.fillModels(demo: true) }
        .onChange(of: searchTerm, perform: viewModel.filterResults(searchTerm:))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
