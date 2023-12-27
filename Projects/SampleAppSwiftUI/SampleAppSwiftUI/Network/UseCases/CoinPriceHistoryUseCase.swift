//
//  CoinPriceHistoryUseCase.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 31.05.2023.
//

import Foundation

protocol CoinPriceHistoryUseCaseProtocol {
    func getDailyPriceHistory(coinCode: String, unitToBeConverted: String, dayLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryUIModel
    func getHourlyPriceHistory(coinCode: String, unitToBeConverted: String, hourLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryUIModel
}

class CoinPriceHistoryUseCase: CoinPriceHistoryUseCaseProtocol {

    let coinPriceHistoryRepository: CoinPriceHistoryRepositoryProtocol

    init(coinPriceHistoryRepository: CoinPriceHistoryRepositoryProtocol = CoinPriceHistoryRepository()) {
        self.coinPriceHistoryRepository = coinPriceHistoryRepository
    }

    func getDailyPriceHistory(coinCode: String, unitToBeConverted: String, dayLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryUIModel {
        let responseModel = try await coinPriceHistoryRepository.getDailyPriceHistory(coinCode: coinCode,
                                                                                      unitToBeConverted: unitToBeConverted,
                                                                                      dayLimit: dayLimit,
                                                                                      aggregate: aggregate)

        return CoinPriceHistoryUIModel(from: responseModel)
    }

    func getHourlyPriceHistory(coinCode: String, unitToBeConverted: String, hourLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryUIModel {
        let responseModel = try await coinPriceHistoryRepository.getHourlyPriceHistory(coinCode: coinCode, 
                                                                                       unitToBeConverted: unitToBeConverted,
                                                                                       hourLimit: hourLimit,
                                                                                       aggregate: aggregate)

        return CoinPriceHistoryUIModel(from: responseModel)
    }
}
