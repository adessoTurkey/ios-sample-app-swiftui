//
//  ContentView.swift
//  SampleWatchAppSwiftUI Watch App
//
//  Created by Yildirim, Alper on 11.10.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            switch viewModel.pageState {
                case .empty:
                    emptyListView()
                case .error:
                    errorView()
                case .finished, .fetching:
                    coinListView()
                default:
                    loadingView()
            }
        }
        .onFirstAppear {
            Task {
                await viewModel.fetchScreen()
            }
        }
    }

    @ViewBuilder func loadingView() -> some View {
        VStack {
            Text(viewModel.homeViewType.currentPageTitle)
                .padding(.bottom, 16)

            ProgressView()
        }
    }

    @ViewBuilder func errorView() -> some View {
        Text("An error occured")
    }

    @ViewBuilder func emptyListView() -> some View {
        VStack(alignment: .center) {
            Text(viewModel.homeViewType.currentPageTitle + " is empty.")
                .multilineTextAlignment(.center)

            if viewModel.homeViewType == .favorites {
                Text("You can add favorite coins using the application from your phone.")
                    .multilineTextAlignment(.center)
                    .font(.caption2)
                    .padding(.top, 8)
            }
            Spacer()

            Button {
                Task {
                    await viewModel.toggleViewType()
                }
            } label: {
                Text("Switch to " + viewModel.homeViewType.alternativePageTitle)
            }

        }
    }

    @ViewBuilder func coinListView() -> some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                List(viewModel.coinList, id: \.id) { coin in
                    NavigationLink(destination: CoinDetailView(coin: coin)) {
                        CoinCardView(coin: coin)
                            .onAppear {
                                viewModel.checkLastItem(coin)
                            }
                    }
                    .listItemTint(coin.getBackgroundColor())
                }
                .refreshable {
                    Task {
                        await viewModel.fetchScreen()
                    }
                }
                .navigationTitle(viewModel.homeViewType.currentPageTitle)
                .listStyle(.elliptical)
            }

            if viewModel.pageState == .fetching {
                ProgressView()
            }

            Button {
                Task {
                   await viewModel.toggleViewType()
                }
            } label: {
                Image(systemName: viewModel.homeViewType.imageSystemName)
                    .foregroundColor(.blue)
                    .padding()
            }
            .buttonStyle(.bordered)
            .background(.black.opacity(0.9))
            .frame(width: 30, height: 30)
            .mask(Circle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
