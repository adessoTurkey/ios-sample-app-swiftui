//
//  CoinNewsService.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

public protocol CoinNewsServiceProtocol {
    func coinNewsRequest(requestModel: CoinNewsRequestModel) async throws -> CoinNewsResponse
}

public final class CoinNewsService: CoinNewsServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = CoinNewsEndpoints
    var networkLoader: NetworkLoaderProtocol

    public init(networkLoader: NetworkLoaderProtocol = NetworkLoader.shared){
        self.networkLoader = networkLoader
    }

    public func coinNewsRequest(requestModel: CoinNewsRequestModel) async throws -> CoinNewsResponse {
        let urlString = build(endpoint: .coinNews(coinCode: requestModel.coinCode))
        
        return try await request(with: RequestObject(url: urlString), responseModel: CoinNewsResponse.self)
    }
}
