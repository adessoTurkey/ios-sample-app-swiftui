//
//  CoinPriceHistoryService.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

public protocol CoinPriceHistoryServiceProtocol {
    func dailyPriceHistoryRequest(requestModel: CoinPriceHistoryRequestModel) async throws -> CoinPriceHistoryResponse
    func hourlyPriceHistoryRequest(requestModel: CoinPriceHistoryRequestModel) async throws -> CoinPriceHistoryResponse
}

public final class CoinPriceHistoryService: CoinPriceHistoryServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = CoinPriceHistoryEndpoints
    var networkLoader: NetworkLoaderProtocol

    public init(networkLoader: NetworkLoaderProtocol = NetworkLoader.shared){
        self.networkLoader = networkLoader
    }

    public func dailyPriceHistoryRequest(requestModel: CoinPriceHistoryRequestModel) async throws -> CoinPriceHistoryResponse {
        let urlString = build(endpoint: .daily(coinCode: requestModel.coinCode,
                                               unitToBeConverted: requestModel.unitToBeConverted,
                                               dayLimit: requestModel.limit,
                                               aggregate: requestModel.aggregate))

        return try await request(with: RequestObject(url: urlString), responseModel: CoinPriceHistoryResponse.self)
    }

    public func hourlyPriceHistoryRequest(requestModel: CoinPriceHistoryRequestModel) async throws -> CoinPriceHistoryResponse {
        let urlString = build(endpoint: .hourly(coinCode: requestModel.coinCode,
                                               unitToBeConverted: requestModel.unitToBeConverted,
                                               hourLimit: requestModel.limit,
                                               aggregate: requestModel.aggregate))

        return try await request(with: RequestObject(url: urlString), responseModel: CoinPriceHistoryResponse.self)
    }
}
