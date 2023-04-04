//
//  CoinListView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import SwiftUI

struct CoinListView: View {
    var filteredCoins: [CoinInfo]

    var body: some View {
        if filteredCoins.isEmpty {
            VStack {
                Spacer(minLength: Dimensions.emptySpaceEstimatedSize)
                Text("No Coins found.")
                    .bold()
                Spacer()
            }
        } else {
            ForEach(filteredCoins) { coin in
                NavigationLink(destination: CoinDetailView()) {
                    CoinView(coinInfo: coin)
                        .tint(.label)
                }
            }.animation(.easeInOut, value: filteredCoins)
        }
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView(filteredCoins: [.demo])
    }
}
