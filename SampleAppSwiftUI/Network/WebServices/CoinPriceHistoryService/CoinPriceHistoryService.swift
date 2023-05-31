//
//  CoinPriceHistoryService.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 29.05.2023.
//

import Foundation

protocol CoinPriceHistoryServiceProtocol {
    func dailyPriceHistoryRequest(coinCode: String, unitToBeConverted: String, dayLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryResponse
    func hourlyPriceHistoryRequest(coinCode: String, unitToBeConverted: String, hourLimit: Int, aggregate: Int) async throws -> CoinPriceHistoryResponse
}

final class CoinPriceHistoryService: CoinPriceHistoryServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = CoinPriceHistoryServiceEndpoint

    let networkLoader: NetworkLoaderProtocol

    init(networkLoader: NetworkLoaderProtocol = NetworkLoaderProvider.shared.networkLoader) {
        self.networkLoader = networkLoader
    }

    func dailyPriceHistoryRequest(coinCode: String, unitToBeConverted: String = "USD", dayLimit: Int = 30, aggregate: Int = 1) async throws -> CoinPriceHistoryResponse {
        let urlString = build(endpoint: .daily(coinCode: coinCode, unitToBeConverted: unitToBeConverted, dayLimit: dayLimit, aggregate: aggregate))
        return try await request(with: RequestObject(url: urlString), responseModel: CoinPriceHistoryResponse.self)
    }

    func hourlyPriceHistoryRequest(coinCode: String, unitToBeConverted: String = "USD", hourLimit: Int = 30, aggregate: Int = 1) async throws -> CoinPriceHistoryResponse {
        let urlString = build(endpoint: .hourly(coinCode: coinCode, unitToBeConverted: unitToBeConverted, hourLimit: hourLimit, aggregate: aggregate))
        return try await request(with: RequestObject(url: urlString), responseModel: CoinPriceHistoryResponse.self)
    }
}
