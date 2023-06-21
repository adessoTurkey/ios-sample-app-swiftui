//
//  CoinListView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import SwiftUI

struct CoinListView: View {
    @Binding var filteredCoins: [CoinData]
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @EnvironmentObject private var router: Router
    let favoriteChanged: () -> Void

    var body: some View {
        if filteredCoins.isEmpty {
            VStack {
                Spacer(minLength: Dimensions.emptySpaceEstimatedSize)
                Text("No Coins found.")
                    .bold()
                Spacer()
            }
        } else {
            List {
                ForEach(filteredCoins) { coin in
                    if let coinInfo = coin.coinInfo,
                       coin.detail != nil {
                        CoinView(coinInfo: coin)
                        .onTapGesture {
                            navigateCoinDetail(coinData: coin)
                        }
                        .listRowInsets(.init())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .swipeActions {
                            Button {
                                checkFavorite(code: coinInfo.code ?? "")
                            } label: {
                                Image(systemName: Images.favorites)
                            }
                            .tint(StorageManager.shared.isCoinFavorite(code: coinInfo.code ?? "") ? .red : .green)
                        }
                        .accessibilityIdentifier("coinView")
                    }
                }
            }
            .listStyle(.plain)
            .animation(.easeInOut, value: filteredCoins)
            .alert(isPresented: $showingAlert, content: configureAlert)
        }
    }

    private func navigateCoinDetail(coinData: CoinData) {
        router.navigateCoinDetail(coinData: coinData)
    }

    func checkFavorite(code: String) {
        self.alertTitle = StorageManager.shared.manageFavorites(code: code)
        showingAlert.toggle()
        favoriteChanged()
    }

    func configureAlert() -> Alert {
        Alert(title: Text(alertTitle), dismissButton: .default(Text("Got it!")))
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoinListView(filteredCoins: .constant([.demo, .demo, .demo]), favoriteChanged: {})
        }
    }
}
