//
//  CoinDetailViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 26.05.2023.
//

import Foundation

class CoinDetailViewModel: ObservableObject {
    let coinData: CoinData
    @Published private(set) var isFavorite: Bool = false
    @Published var chartHistoryRangeSelection: CoinChartHistoryRange = .sixMonth {
        didSet {
            fetchCoinPriceHistory(forSelectedRange: chartHistoryRangeSelection)
        }
    }
    @Published private(set) var coinPriceHistoryChartDataModel: CoinPriceHistoryChartDataModel?
    @Published private(set) var coinNewsDataModel: [CoinNewData]?
    @Published private(set) var isLoading: Bool = false
    @Published var priceChartSelectedXDateText: String = ""

    var rangeButtonsOpacity: Double {
        priceChartSelectedXDateText.isEmpty ? 1.0 : 0.0
    }

    private let coinPriceHistoryUseCase: CoinPriceHistoryUseCaseProtocol
    private let coinNewsUseCase: CoinNewsUseCaseProtocol

    init(coinData: CoinData,
         coinPriceHistoryUseCase: CoinPriceHistoryUseCaseProtocol = CoinPriceHistoryUseCase(),
         coinNewsUseCase: CoinNewsUseCaseProtocol = CoinNewsUseCase()) {
        self.coinData = coinData
        self.coinPriceHistoryUseCase = coinPriceHistoryUseCase
        self.coinNewsUseCase = coinNewsUseCase
    }

    func onAppear() {
        checkIsCoinFavorite()
        fetchCoinPriceHistory(forSelectedRange: chartHistoryRangeSelection)
        fetchCoinNews()
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
        isFavorite = CoreDataManager.shared.isCoinFavorite(coinData.coinInfo?.code ?? "")
    }

    func updateCoinFavoriteState() {
        isFavorite.toggle()
        CoreDataManager.shared.manageFavorites(coinData: coinData)
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

    func fetchCoinNews() {
        guard let coinCode = coinData.coinInfo?.code else { return }

        Task {
            var response: CoinNewsResponse?
            response = try? await coinNewsUseCase.getCoinNews(coinCode: coinCode)

            guard let response = response, let coinNewData = response.data else { return }
            DispatchQueue.main.async {
                self.coinNewsDataModel = coinNewData
            }
        }
    }
}
