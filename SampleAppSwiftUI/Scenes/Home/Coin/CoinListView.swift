//
//  CoinListView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import SwiftUI

struct CoinListView: View {
    var filteredCoins: [CoinInfo]

    @StateObject private var viewModel = CoinInfoViewModel()
    @State private var showingAlert = false
    @State private var alertTitle = ""

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
                    NavigationLink(destination: CoinDetailView()) {
                        CoinView(coinInfo: coin, viewModel: viewModel)
                    }
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .swipeActions {
                        Button {
                            checkFavorite(code: coin.code)
                        } label: {
                            Image(systemName: Images.favorites)
                        }
                        .tint(viewModel.isCoinFavorite(code: coin.code) ? .red : .green)
                    }
                }
            }
            .frame(minHeight: UIScreen.main.bounds.height)
            .listStyle(.plain)
            .animation(.easeInOut, value: filteredCoins)
            .alert(isPresented: $showingAlert, content: configureAlert)
        }
    }

    func checkFavorite(code: String) {
        self.alertTitle = viewModel.manageFavorites(code: code)
        showingAlert.toggle()
    }

    func configureAlert() -> Alert {
        Alert(title: Text(alertTitle), dismissButton: .default(Text("Got it!")))
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoinListView(filteredCoins: [.demo, .demo, .demo])
        }
    }
}
