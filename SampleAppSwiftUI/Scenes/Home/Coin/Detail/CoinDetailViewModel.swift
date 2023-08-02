//
//  CoinDetailViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 26.05.2023.
//

import Foundation
import Observation

@Observable
class CoinDetailViewModel {
    let coinData: CoinData
    private(set) var isFavorite: Bool = false
    var chartHistoryRangeSelection: CoinChartHistoryRange = .sixMonth {
        didSet {
            fetchCoinPriceHistory(forSelectedRange: chartHistoryRangeSelection)
        }
    }
    private(set) var coinPriceHistoryChartDataModel: CoinPriceHistoryChartDataModel?
    private(set) var isLoading: Bool = false
    var priceChartSelectedXDateText: String = ""

    var rangeButtonsOpacity: Double {
        priceChartSelectedXDateText.isEmpty ? 1.0 : 0.0
    }

    private let coinPriceHistoryUseCase: CoinPriceHistoryUseCaseProtocol

    init(coinData: CoinData, coinPriceHistoryUseCase: CoinPriceHistoryUseCaseProtocol = CoinPriceHistoryUseCase()) {
        self.coinData = coinData
        self.coinPriceHistoryUseCase = coinPriceHistoryUseCase
    }

    func onAppear() {
        checkIsCoinFavorite()
        fetchCoinPriceHistory(forSelectedRange: chartHistoryRangeSelection)
    }

    func getIconURL() -> URL? {
        guard let coinCode = coinData.coinInfo?.code else {
            return nil
        }

        return URLs.Icons.getURL(from: coinCode)
    }

    func getPriceString() -> String {
        coinData.detail?.usd?.createPriceString() ?? ""
    }

    func checkIsCoinFavorite() {
        isFavorite = StorageManager.shared.isCoinFavorite(coinData.coinInfo?.code ?? "")
    }

    func updateCoinFavoriteState() {
        isFavorite.toggle()
        StorageManager.shared.manageFavorites(coinData: coinData)
    }

    func fetchCoinPriceHistory(forSelectedRange range: CoinChartHistoryRange) {
        guard let coinCode = coinData.coinInfo?.code else { return }

        isLoading = true

        Task {
            var response: CoinPriceHistoryResponse?

            let limitAndAggregate = range.limitAndAggregateValue

            if range == .oneDay {
                response = try? await coinPriceHistoryUseCase.getHourlyPriceHistory(
                    coinCode: coinCode,
                    unitToBeConverted: "USD",
                    hourLimit: limitAndAggregate.limit,
                    aggregate: limitAndAggregate.aggregate
                )
            } else {
                response = try? await coinPriceHistoryUseCase.getDailyPriceHistory(
                    coinCode: coinCode,
                    unitToBeConverted: "USD",
                    dayLimit: limitAndAggregate.limit,
                    aggregate: limitAndAggregate.aggregate
                )
            }

            guard let response = response, let priceHistoryData = response.data else { return }

            DispatchQueue.main.async {
                self.isLoading = false
                self.coinPriceHistoryChartDataModel = CoinPriceHistoryChartDataModel(from: priceHistoryData)
            }
        }
    }
}
