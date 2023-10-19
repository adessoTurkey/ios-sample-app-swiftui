//
//  CoinDetailViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 26.05.2023.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    @Published var isFavorite: Bool = false
    @Published var chartHistoryRangeSelection: CoinChartHistoryRange = .sixMonth
    private(set) var coinPriceHistoryChartDataModel: CoinPriceHistoryChartDataModel?
    @Published var isLoading = false
    @Published var coinNewsDataModel: [CoinNewData]?
    @Published var priceChartSelectedXDateText = ""

    var rangeButtonsOpacity: Double {
        priceChartSelectedXDateText.isEmpty ? 1.0 : 0.0
    }

    private let coinPriceHistoryUseCase: CoinPriceHistoryUseCaseProtocol = CoinPriceHistoryUseCase()
    private let coinNewsUseCase: CoinNewsUseCaseProtocol = CoinNewsUseCase()

    func onAppear(coinData: CoinData) async {
        await checkIsCoinFavorite(coinData: coinData)
        await fetchCoinPriceHistory(
            coinData: coinData,
            forSelectedRange: chartHistoryRangeSelection
        )
        await fetchCoinNews(coinData: coinData)
    }

    func getIconURL(coinData: CoinData) -> URL? {
        guard let coinCode = coinData.coinInfo?.code else {
            return nil
        }

        return URLs.Icons.getURL(from: coinCode)
    }

    func getPriceString(coinData: CoinData) -> String {
        coinData.detail?.usd?.createPriceString() ?? ""
    }

    func checkIsCoinFavorite(coinData: CoinData) async {
        await MainActor.run {
            isFavorite = StorageManager.shared.isCoinFavorite(coinData.coinInfo?.code ?? "")
        }
    }

    func updateCoinFavoriteState(coinData: CoinData) {
        isFavorite.toggle()
        StorageManager.shared.manageFavorites(coinData: coinData)
    }

    func fetchCoinPriceHistory(coinData: CoinData, forSelectedRange range: CoinChartHistoryRange) async {
        guard let coinCode = coinData.coinInfo?.code else { return }

        await MainActor.run {
            isLoading = true
        }
        do {
            var response: CoinPriceHistoryResponse?
            let limitAndAggregate = range.limitAndAggregateValue
            switch range {
                case .oneDay:
                    response = try await coinPriceHistoryUseCase.getHourlyPriceHistory(
                        coinCode: coinCode,
                        unitToBeConverted: "USD",
                        hourLimit: limitAndAggregate.limit,
                        aggregate: limitAndAggregate.aggregate
                    )
                default:
                    response = try await coinPriceHistoryUseCase.getDailyPriceHistory(
                        coinCode: coinCode,
                        unitToBeConverted: "USD",
                        dayLimit: limitAndAggregate.limit,
                        aggregate: limitAndAggregate.aggregate
                    )
            }
            if let response = response, let priceHistoryData = response.data {
                await MainActor.run {
                    isLoading = false
                    coinPriceHistoryChartDataModel = CoinPriceHistoryChartDataModel(from: priceHistoryData)
                }
            } else {
                await MainActor.run {
                    isLoading = false
                }
            }
        } catch let error {
            LoggerManager().setError(errorMessage: error.localizedDescription)
        }
    }

    func fetchCoinNews(coinData: CoinData) async {
        guard let coinCode = coinData.coinInfo?.code else { return }
        do {
            let response = try await coinNewsUseCase.getCoinNews(coinCode: coinCode)
            if let data = response.data {
                await MainActor.run {
                    coinNewsDataModel = data
                }
            }
        } catch let error {
            LoggerManager().setError(errorMessage: error.localizedDescription)
        }
    }
}
