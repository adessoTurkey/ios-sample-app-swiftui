//
//  CoinVerticalListView.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 29.12.2023.
//

import SwiftUI

struct CoinVerticalListView: View {
    let coins: [CoinUIModel]

    var body: some View {
        List(coins, id: \.id) { coin in
            NavigationLink(destination: CoinDetailView(coin: coin)) {
                CoinListItemView(coin: coin)
            }
        }
    }
}

struct CoinListItemView: View {
    private let favoriteManager = FavoriteCoinsManager()

    @State var isFavorite: Bool = false
    let coin: CoinUIModel

    var body: some View {
        HStack {
            CoinLogoView(code: coin.coinInfo?.code)
                .frame(width: 100, height: 100)

            Text(coin.coinInfo?.title ?? "")
                .font(.title)

            Spacer()

            if isFavorite {
                Image(systemName: "heart.fill")
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                self.isFavorite = self.favoriteManager.checkIfFavorite(coin)
            }
        }
    }
}

#Preview {
    CoinVerticalListView(coins: [CoinUIModel.demo, CoinUIModel.demo, CoinUIModel.demo])
}
