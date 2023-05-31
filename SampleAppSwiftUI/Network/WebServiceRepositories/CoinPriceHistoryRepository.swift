//
//  CoinPriceHistoryRepository.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 31.05.2023.
//

import Foundation

protocol CoinPriceHistoryRepositoryProtocol {
    func getDailyPriceHistory(coinCode: String, unitToBeConverted: String, dayLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryResponse
    func getHourlyPriceHistory(coinCode: String, unitToBeConverted: String, hourLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryResponse
}

class CoinPriceHistoryRepository: CoinPriceHistoryRepositoryProtocol {

    let coinPriceHistoryRemoteDataSource: CoinPriceHistoryRemoteDataSourceProtocol

    init(coinPriceHistoryRemoteDataSource: CoinPriceHistoryRemoteDataSourceProtocol = CoinPriceHistoryRemoteDataSource()) {
        self.coinPriceHistoryRemoteDataSource = coinPriceHistoryRemoteDataSource
    }

    func getDailyPriceHistory(coinCode: String, unitToBeConverted: String, dayLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryResponse {
        try await coinPriceHistoryRemoteDataSource.getDailyPriceHistory(coinCode: coinCode, unitToBeConverted: unitToBeConverted, dayLimit: dayLimit, aggregate: aggregate)
    }

    func getHourlyPriceHistory(coinCode: String, unitToBeConverted: String, hourLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryResponse {
        try await coinPriceHistoryRemoteDataSource.getHourlyPriceHistory(coinCode: coinCode, unitToBeConverted: unitToBeConverted, hourLimit: hourLimit, aggregate: aggregate)
    }
}
