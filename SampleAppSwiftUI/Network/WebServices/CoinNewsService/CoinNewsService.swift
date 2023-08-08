//
//  CoinNewsService.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 20.07.2023.
//

import Foundation

protocol CoinNewsServiceProtocol {
    func coinNewsRequest(coinCode: String) async throws -> CoinNewsResponse
}

final class CoinNewsService: CoinNewsServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = CoinNewsServiceEndpoint
    
    var networkLoader: NetworkLoaderProtocol
    
    init(networkLoader: NetworkLoaderProtocol = NetworkLoaderProvider.shared.networkLoader) {
        self.networkLoader = networkLoader
    }
    
    func coinNewsRequest(coinCode: String) async throws -> CoinNewsResponse {
        let urlString = build(endpoint: .coinNews(coinCode: coinCode))
        return try await request(with: RequestObject(url: urlString), responseModel: CoinNewsResponse.self)
    }
}
