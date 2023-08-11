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
    
    @StateObject private var viewModel: CoinDetailViewModel

    init(coinData: CoinData) {
        _viewModel = StateObject(wrappedValue: CoinDetailViewModel(coinData: coinData))
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    AsyncImage(url: viewModel.getIconURL()) { phase in
                        if let image = phase.image {
                            image.resizable()
                        } else if phase.error != nil {
                            VStack {
                                Resources.Images.defaultCoin.swiftUIImage.resizable()
                            }
                        } else {
                            ProgressView()
                                .imageFrame()
                        }
                    }
                    .scaledToFit()
                    .imageFrame(width: Dimensions.imageWidth * 2, height: Dimensions.imageHeight * 2)

                    Text(verbatim: viewModel.getPriceString())

                    ChangePercentageView(changeRate: viewModel.coinData.detail?.usd ?? .init())

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
                                    selectedXDateText: $viewModel.priceChartSelectedXDateText
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
                NavigationView {
                    VStack {
                        if let newsModel = viewModel.coinNewsDataModel {
                            List {
                                Section(Strings.news) {
                                    ForEach(newsModel.prefix(5)) { model in
                                        NavigationLink(destination: WebView(url: URL(string: model.url))) {
                                            HStack {
                                                AsyncImage(url: URL(string: model.imageurl)) { phase in
                                                    if let image = phase.image {
                                                        image.resizable()
                                                    } else {
                                                        Resources.Images.worldNews.swiftUIImage.resizable()
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
                Button {
                } label: {
                    NavigationLink(destination: CoinNewsListView(coinData: viewModel.coinData)) {
                        Text("View More")
                            .frame(width: UIScreen.main.bounds.size.width - CoinDetailView.coinListFrameSize)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(Color.searchIcon)
                    }
                }.background(Color.lightGray)
                    .cornerRadius(CoinDetailView.viewMoreButton)
                Spacer()
            }
            .navigationTitle(Text(verbatim: viewModel.coinData.coinInfo?.title ?? ""))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.updateCoinFavoriteState()
                    } label: {
                        viewModel.isFavorite
                        ? Image(systemName: Images.favorites)
                        : Image(systemName: Images.star)
                    }
                    .tint(.gray)
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinDetailView(coinData: CoinData.demo)
            NavigationView {
                CoinDetailView(coinData: CoinData.demo)
            }
        }
    }
}
