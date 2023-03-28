//
//  CoinListView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import SwiftUI

struct CoinListView: View {
    var viewModel: HomeViewModel

    var body: some View {
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

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView(viewModel: .init())
    }
}
