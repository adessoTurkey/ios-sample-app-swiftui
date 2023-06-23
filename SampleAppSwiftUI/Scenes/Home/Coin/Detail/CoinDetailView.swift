//
//  CoinDetailView.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 22.05.2023.
//

import SwiftUI

struct CoinDetailView: View {
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
                    .frame(minHeight: 300)
                    .cornerRadius(Dimensions.CornerRadius.default)
                }
                .padding(.horizontal, Paddings.side)
                .padding(.vertical, Paddings.CoinDetailView.top)
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
