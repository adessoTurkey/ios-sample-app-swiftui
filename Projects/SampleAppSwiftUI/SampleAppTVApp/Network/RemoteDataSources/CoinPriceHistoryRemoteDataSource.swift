//
//  CoinPriceHistoryRemoteDataSource.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 29.05.2023.
//

import Foundation
import NetworkService

protocol CoinPriceHistoryRemoteDataSourceProtocol {
    func getDailyPriceHistory(coinCode: String, unitToBeConverted: String, dayLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryResponse
    func getHourlyPriceHistory(coinCode: String, unitToBeConverted: String, hourLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryResponse
}

class CoinPriceHistoryRemoteDataSource: CoinPriceHistoryRemoteDataSourceProtocol {

    let coinPriceHistoryService: CoinPriceHistoryServiceProtocol

    init(coinPriceHistoryService: CoinPriceHistoryServiceProtocol = WebServiceProvider.shared.coinPriceHistoryService) {
        self.coinPriceHistoryService = coinPriceHistoryService
    }

    func getDailyPriceHistory(coinCode: String,
                              unitToBeConverted: String,
                              dayLimit: Int,
                              aggregate: Int) async throws -> CoinPriceHistoryResponse {
        try await coinPriceHistoryService.dailyPriceHistoryRequest(
            requestModel: CoinPriceHistoryRequestModel(
                coinCode: coinCode,
                unitToBeConverted: unitToBeConverted,
                limit: dayLimit,
                aggregate: aggregate
            )
        )
    }

    func getHourlyPriceHistory(coinCode: String,
                               unitToBeConverted: String,
                               hourLimit: Int,
                               aggregate: Int) async throws -> CoinPriceHistoryResponse {
        try await coinPriceHistoryService.hourlyPriceHistoryRequest(
            requestModel: CoinPriceHistoryRequestModel(
                coinCode: coinCode,
                unitToBeConverted: unitToBeConverted,
                limit: hourLimit,
                aggregate: aggregate
            )
        )
    }
}
