//
//  CoinNewsDataSource.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 20.07.2023.
//

import Foundation

protocol CoinNewsRemoteDataSourceProtocol {
    func getCoinNews(coinCode: String) async throws -> CoinNewsResponse
}

class CoinNewsRemoteDataSource: CoinNewsRemoteDataSourceProtocol {
    let coinNewsService: CoinNewsServiceProtocol

    init(coinNewsService: CoinNewsServiceProtocol = WebServiceProvider.shared.coinNewsService) {
        self.coinNewsService = coinNewsService
    }

    func getCoinNews(coinCode: String) async throws -> CoinNewsResponse {
        try await coinNewsService.coinNewsRequest(coinCode: coinCode)
    }
}
