//
//  HomeView.swift
//  boilerplate-ios-swiftui
//
//  Created by Cagri Gider on 14.08.2022.
//  Copyright © 2022 Adesso Turkey. All rights reserved.
//

import SwiftUI
import PulseUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    @State private var searchTerm = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    SearchBarView(searchText: $searchTerm)
                        .padding(.top, 76)
                        .padding(.bottom, 18)
                    filterView
                        .padding(.bottom, 12)
                    coinListView()
                }
                .padding([.leading, .trailing], 16)
            }
            .ignoresSafeArea(.all, edges: .top)
        }
        .background(Color.lightGray)
        .ignoresSafeArea(.all, edges: [.top, .trailing, .leading])
        //.task { viewModel.startSocketConnection() }
        .onAppear { viewModel.fillModels(demo: true) }
        .onChange(of: searchTerm, perform: viewModel.filterResults(searchTerm:))
    }

}

extension HomeView {
    var filterView: some View {
        HStack {
            Text(viewModel.filterTitle)
            Spacer()
            Image(systemName: "slider.horizontal.3")
        }
    }

    @ViewBuilder
    func coinListView() -> some View {
        if viewModel.filteredCoins.isEmpty {
            VStack {
                Spacer(minLength: 200)
                Text("No Coins found.")
                    .bold()
                Spacer()
            }
        } else {
            ForEach(viewModel.filteredCoins) { coin in
                NavigationLink(destination: CoinDetailView()) {
                    CoinView(coinInfo: coin)
                        .tint(Color(uiColor: .label))
                }
            }.animation(.easeInOut, value: viewModel.filteredCoins)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
