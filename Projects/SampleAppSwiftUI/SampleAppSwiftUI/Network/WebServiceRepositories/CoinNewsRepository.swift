//
//  CoinNewsRepository.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 20.07.2023.
//

import Foundation
import NetworkService

protocol CoinNewsRepositoryProtocol {
    func getCoinNews(coinCode: String) async throws -> CoinNewsResponse
}

class CoinNewsRepository: CoinNewsRepositoryProtocol {
    let coinNewsRemoteDataSource: CoinNewsRemoteDataSourceProtocol

    init(coinNewsRemoteDataSource: CoinNewsRemoteDataSourceProtocol = CoinNewsRemoteDataSource()) {
        self.coinNewsRemoteDataSource = coinNewsRemoteDataSource
    }

    func getCoinNews(coinCode: String) async throws -> CoinNewsResponse {
        try await coinNewsRemoteDataSource.getCoinNews(coinCode: coinCode)
    }
}
