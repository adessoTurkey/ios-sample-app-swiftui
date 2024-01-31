//
//  PriceChartViewModel.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 29.12.2023.
//

import Foundation
import SwiftUI
import Charts

class PriceChartViewModel: ObservableObject {
    @Published var dataModel: CoinPriceHistoryChartDataModel?
    @Published var pageState: PageState = .idle

    private let coinPriceHistoryUseCase: CoinPriceHistoryUseCaseProtocol

    init(coinPriceHistoryUseCase: CoinPriceHistoryUseCaseProtocol = CoinPriceHistoryUseCase()) {
        self.coinPriceHistoryUseCase = coinPriceHistoryUseCase
    }

    private let selectedValueDateFormatter = {
        let dfm = DateFormatter()
        dfm.dateStyle = .medium
        return dfm
    }()

    var chartYScaleDomain: ClosedRange<Float> {
        let averages = dataModel?.prices.map { $0.average } ?? []
        let min = (averages.min() ?? 0)
        let max = (averages.max() ?? 1)
        return min...max
    }

    var chartXScaleDomain: ClosedRange<Date> {
        guard let firstDate = dataModel?.prices.first?.date, let lastDate = dataModel?.prices.last?.date else { return Date()...Date().advanced(by: 3600) }

        return firstDate...lastDate
    }

    var coinPrices: [CoinPriceInfoChartDataModel] {
        dataModel?.prices ?? []
    }

    func fetchCoinPriceHistory(for coin: CoinUIModel) async {
        pageState = .loading
        guard let coinCode = coin.coinInfo?.code else {
            pageState = .error
            return
        }

        Task {
            let response = try? await coinPriceHistoryUseCase.getDailyPriceHistory(
                coinCode: coinCode,
                unitToBeConverted: "USD",
                dayLimit: 24,
                aggregate: 1
            )

            guard let response = response, let priceHistoryData = response.data else {
                pageState = .empty
                return
            }

            DispatchQueue.main.async {
                self.dataModel = CoinPriceHistoryChartDataModel(from: priceHistoryData)
                self.pageState = .finished
            }
        }
    }

    func format(price: Double) -> String {
        price.formatted(.number.precision(.fractionLength(2)))
    }
}
