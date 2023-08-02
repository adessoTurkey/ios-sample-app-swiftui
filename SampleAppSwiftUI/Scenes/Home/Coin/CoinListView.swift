//
//  CoinListView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import SwiftUI
import PreviewSnapshots

struct CoinListView<ViewModel: ViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
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
                        .onAppear {
                            viewModel.checkLastItem(coin)
                        }
                        .onTapGesture {
                            navigateCoinDetail(coinData: coin)
                        }
                        .listRowInsets(.init())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .swipeActions {
                            Button {
                                checkFavorite(coinData: coin)
                            } label: {
                                Image(systemName: Images.favorites)
                            }
                            .tint(StorageManager.shared.isCoinFavorite(coinInfo.code ?? "") ? .red : .green)
                        }
                        .accessibilityIdentifier("coinView")
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
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

    func checkFavorite(coinData: CoinData) {
        self.alertTitle = StorageManager.shared.manageFavorites(coinData: coinData)
        showingAlert.toggle()
        favoriteChanged()
    }

    func configureAlert() -> Alert {
        Alert(title: Text(alertTitle), dismissButton: .default(Text("Got it!")))
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews
    }

    static var snapshots: PreviewSnapshots<[CoinData]> {
        .init(configurations: [
            .init(name: "One coin", state: [.demo]),
            .init(name: "Two coins", state: [.demo, CoinData.demoCoin(from: "DOGE")]),
            .init(name: "Three coins", state: [.demo,
                                               CoinData.demoCoin(from: "DOGE"),
                                               CoinData.demoCoin(from: "ETH")]),
            .init(name: "Four coins", state: [.demo,
                                              CoinData.demoCoin(from: "DOGE"),
                                              CoinData.demoCoin(from: "ETH"),
                                              CoinData.demoCoin(from: "FTM")])
        ], configure: { state in
            CoinListView(viewModel: HomeViewModel(), filteredCoins: .constant(state), favoriteChanged: {})
        })
    }
}
