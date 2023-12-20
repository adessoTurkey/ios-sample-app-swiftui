//
//  AllCoinUseCase.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

protocol AllCoinUseCaseProtocol {
    func fetchAllCoin(limit: Int, unitToBeConverted: String, page: Int) async throws -> AllCoinUIModel
}

class AllCoinUseCase: AllCoinUseCaseProtocol {
    let allCoinRepository: AllCoinRepositoryProtocol

    init(allCoinRepository: AllCoinRepositoryProtocol = AllCoinRepository()) {
        self.allCoinRepository = allCoinRepository
    }

    func fetchAllCoin(limit: Int, unitToBeConverted: String, page: Int) async throws -> AllCoinUIModel {
        let responseModel = try await allCoinRepository.getAllCoin(limit: limit, unitToBeConverted: unitToBeConverted, page: page)
        return AllCoinUIModel(from: responseModel)
    }
}
