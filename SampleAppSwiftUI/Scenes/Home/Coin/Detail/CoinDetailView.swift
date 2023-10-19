//
//  CoinDetailView.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 22.05.2023.
//

import SwiftUI

struct CoinDetailView: View {

    private enum CoinDetailView {
        static let viewMoreButton: CGFloat = 25
        static let coinListFrameSize: CGFloat = 70
        static let chartHeight: CGFloat = 250
    }

    var coinData: CoinData

    @StateObject private var viewModel = CoinDetailViewModel()

    var coinDetailImage: some View {
        VStack {
            AsyncImage(url: viewModel.getIconURL(coinData: coinData)) { phase in
                if let image = phase.image {
                    image.resizable()
                } else if phase.error != nil {
                    VStack {
                        Image(.defaultCoin)
                            .resizable()
                    }
                } else {
                    ProgressView()
                        .imageFrame()
                }
            }
            .scaledToFit()
            .imageFrame(
                width: Dimensions.imageWidth * 2,
                height: Dimensions.imageHeight * 2
            )

            Text(verbatim: viewModel.getPriceString(coinData: coinData))

            ChangePercentageView(changeRate: coinData.detail?.usd ?? .init())

            ZStack {
                CoinChartHistoryRangeButtons(selection: $viewModel.chartHistoryRangeSelection)
                    .opacity(viewModel.rangeButtonsOpacity)

                Text(verbatim: viewModel.priceChartSelectedXDateText)
                    .font(.headline)
                    .padding(.vertical, 4)
                    .padding(.horizontal)
            }
            .padding(.top, 22)
            .padding(.bottom, 12)

            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: Dimensions.CornerRadius.default)
                    .fill(Color(uiColor: .systemGray6))

                if viewModel.isLoading {
                    ProgressView()
                } else {
                    if let chartDataModel = viewModel.coinPriceHistoryChartDataModel {
                        CoinPriceHistoryChartView(
                            selectedRange: viewModel.chartHistoryRangeSelection,
                            dataModel: chartDataModel,
                            selectedXDateText: viewModel.priceChartSelectedXDateText
                        )
                        .padding(.horizontal, 16)
                        .padding(.top, 34)
                        .padding(.bottom, 18)
                    } else {
                        Text("No price data found")
                    }
                }
            }
            .frame(minHeight: CoinDetailView.chartHeight)
            .cornerRadius(Dimensions.CornerRadius.default)
        }
        .padding(.horizontal, Paddings.side)
        .onReceive(viewModel.$chartHistoryRangeSelection) { selectedRange in
            Task {
                await viewModel.fetchCoinPriceHistory(
                    coinData: coinData,
                    forSelectedRange: selectedRange
                )
            }
        }
    }

    var news: some View {
        NavigationView {
            VStack {
                if let newsModel = viewModel.coinNewsDataModel {
                    List {
                        Section("News") {
                            ForEach(newsModel.prefix(5)) { model in
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
                                            .limitedCharacterCount(Numbers.newsCharCount, model.title, "...")
                                    }
                                }
                            }
                        }
                    }
                    .scrollDisabled(true)
                    .listStyle(.inset)
                }
            }
        }
    }

    var body: some View {
        VStack {
            ScrollView {
                coinDetailImage
                news
                Button {
                } label: {
                    NavigationLink(destination: CoinNewsListView(coinData: coinData)) {
                        Text("View More")
                            .frame(width: UIScreen.main.bounds.size.width - CoinDetailView.coinListFrameSize)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(Color(.searchIcon))
                    }
                }.background(Color(.lightestGray))
                    .cornerRadius(CoinDetailView.viewMoreButton)
                Spacer()
            }
            .navigationTitle(Text(verbatim: coinData.coinInfo?.title ?? ""))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.updateCoinFavoriteState(coinData: coinData)
                    } label: {
                        viewModel.isFavorite
                        ? Image(systemName: Images.favorites)
                        : Image(systemName: Images.star)
                    }
                    .tint(.gray)
                }
            }
            .task {
                await viewModel.onAppear(coinData: coinData)
            }
        }
    }
}

#Preview {
    Group {
        NavigationView {
            CoinDetailView(coinData: CoinData.demo)
                .previewLayout(.sizeThatFits)
        }
    }
}
