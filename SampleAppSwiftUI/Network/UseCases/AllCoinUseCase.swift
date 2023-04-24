//
//  AllCoinUseCase.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

protocol AllCoinUseCaseProtocol {
    func fetchAllCoin() async throws -> AllCoinResponse
}

class AllCoinUseCase: AllCoinUseCaseProtocol {
    let allCoinRepository: AllCoinRepositoryProtocol

    init(allCoinRepository: AllCoinRepositoryProtocol = AllCoinRepository()) {
        self.allCoinRepository = allCoinRepository
    }

    func fetchAllCoin() async throws -> AllCoinResponse {
        try await allCoinRepository.getAllCoin()
    }
}
