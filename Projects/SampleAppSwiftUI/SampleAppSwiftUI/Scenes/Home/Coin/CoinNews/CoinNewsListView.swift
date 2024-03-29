//
//  CoinNewsListView.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 25.07.2023.
//

import SwiftUI

struct CoinNewsListView: View {
    @StateObject private var viewModel: CoinDetailViewModel

    init(coinData: CoinUIModel) {
        _viewModel = StateObject(
            wrappedValue: CoinDetailViewModel(coinData: coinData)
        )
    }

    var body: some View {
        VStack {
            ScrollView {
                NavigationView {
                    if let newsModel = viewModel.coinNewsDataModel {
                        List {
                            ForEach(newsModel) { model in
                                NavigationLink(destination: WebView(url: URL(string: model.url))) {
                                    HStack {
                                        AsyncImage(url: URL(string: model.imageurl)) { phase in
                                            if let image = phase.image {
                                                image.resizable()
                                            } else {
                                                Image(.worldNews)
                                                    .resizable()
                                            }
                                        }
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: Dimensions.imageWidth, height: Dimensions.imageHeight)
                                        Text(model.title)
                                    }
                                }
                            }
                        }
                        .listStyle(.inset)
                    }
                }.frame(height: UIScreen.main.bounds.height)
                    .navigationTitle("News")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationViewStyle(.automatic)
            }
        }
        .task(viewModel.onAppear)
    }
}

struct CoinNewsListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinNewsListView(coinData: CoinUIModel.demo)
    }
}
