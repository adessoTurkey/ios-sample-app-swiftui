//
//  CoinDetailView.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 28.12.2023.
//

import SwiftUI
struct CoinDetailView: View {
    private let favoriteManager = FavoriteCoinsManager()
    private let recentsManager = VisitedCoinsManager()
    @State var isFavorite: Bool = false
    let coin: CoinUIModel

    var coinCodeString: String {
        coin.coinInfo?.title ?? ""
    }

    var body: some View {
        VStack(alignment: .leading) {
            PriceChartView(coin: coin)
                .padding(.vertical, 12)

            Text(coin.coinInfo?.code ?? "")
                .lineLimit(2)
                .font(.subheadline)

            Text(coin.coinInfo?.title ?? "")
                .font(.title3)
                .fontWeight(.bold)

            HStack(alignment: .bottom) {
                Text(coin.detail?.usd?.createPriceString() ?? "")
                    .font(.title)

                Text(coin.detail?.usd?.createChangeText() ?? "")
                    .font(.subheadline)
                    .padding(.bottom, 12)

                Spacer()

                Button(
                    action: {
                       favoriteButtonOnTap()
                    }, label: {
                        Text(isFavorite ? "Remove favorite" : "Favorite")
                    }
                )
            }

        }
        .onAppear {
            detailOnAppear()
        }
        .padding()
    }

    private func detailOnAppear() {
        recentsManager.addRecentlyVisitedCoin(coin)
        DispatchQueue.main.async {
            self.isFavorite = self.favoriteManager.checkIfFavorite(coin)
        }
    }

    private func favoriteButtonOnTap() {
        if favoriteManager.checkIfFavorite(coin) {
            favoriteManager.removeFavoriteCoin(coin)
        } else {
            favoriteManager.addFavoriteCoin(coin)
        }
        DispatchQueue.main.async {
            self.isFavorite.toggle()
        }
    }
}

#Preview {
    CoinDetailView(coin: .demo)
}
