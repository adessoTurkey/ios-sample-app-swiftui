//
//  CoinNewsUseCase.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 20.07.2023.
//

import Foundation

protocol CoinNewsUseCaseProtocol {
    func getCoinNews(coinCode: String) async throws -> CoinNewsUIModel
}

class CoinNewsUseCase: CoinNewsUseCaseProtocol {
    let coinNewsRepository: CoinNewsRepositoryProtocol

    init(coinNewsRepository: CoinNewsRepositoryProtocol = CoinNewsRepository()) {
        self.coinNewsRepository = coinNewsRepository
    }

    func getCoinNews(coinCode: String) async throws -> CoinNewsUIModel {
        let responseModel = try await coinNewsRepository.getCoinNews(coinCode: coinCode)
        return CoinNewsUIModel(from: responseModel)
    }
}
