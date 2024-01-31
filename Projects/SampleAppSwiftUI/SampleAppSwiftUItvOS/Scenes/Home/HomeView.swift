//
//  ContentView.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 28.12.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                HorizontalCardListView(list: viewModel.allCoins, title: HomeListType.topCoins.getTitle())
                    .scrollClipDisabled()
                    .onAppear {
                        Task {
                            await viewModel.fetchData(type: .topCoins)
                        }
                    }

                HorizontalCardListView(list: viewModel.topVolumeCoins, title: HomeListType.topByDailyVolume.getTitle())
                    .scrollClipDisabled()
                    .onAppear {
                        Task {
                            await viewModel.fetchData(type: .topByDailyVolume)
                        }
                    }

                HorizontalCardListView(list: viewModel.favoriteCoins, title: HomeListType.favorites.getTitle())
                    .scrollClipDisabled()
                    .onAppear {
                        Task {
                            await viewModel.fetchData(type: .favorites)
                        }
                    }

                HorizontalCardListView(list: viewModel.recentlyVisited, title: HomeListType.recentlyVisited.getTitle())
                    .scrollClipDisabled()
                    .onAppear {
                        Task {
                            await viewModel.fetchData(type: .recentlyVisited)
                        }
                    }
            }
            .ignoresSafeArea()
            .withAppRouter()
        }
        .environmentObject(router)
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())
}

struct HorizontalCardListView: View {
    @EnvironmentObject private var router: Router

    var list: [CoinUIModel]
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.leading, 16)
                    .font(.title2)

                Button(
                    action: {
                        router.navigate(to: .coinList(list: list))
                    },
                    label: {
                        Text("Show list")
                    }
                )
                .buttonStyle(.bordered)
            }

            ScrollView(.horizontal) {
                LazyHStack(spacing: .zero) {
                    ForEach(list, id: \.id) { coin in
                        CoinCardView(coin: coin)
                            .padding(.leading, 16)
                    }
                }
            }
            .padding(.top, 16)
        }
        .padding(.vertical, 16)
    }
}
