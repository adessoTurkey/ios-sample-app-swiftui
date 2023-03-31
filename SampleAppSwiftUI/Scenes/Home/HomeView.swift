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
                VStack(spacing: 10) {
                    SearchBarView(searchText: $searchTerm, topPadding: 76)
                        .padding(.bottom, 18)
                    HomeFilterView(filterTitle: viewModel.filterTitle)
                        .padding(.bottom, 12)
                    CoinListView(filteredCoins: viewModel.filteredCoins)
                }
                .padding([.leading, .trailing], 16)
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
