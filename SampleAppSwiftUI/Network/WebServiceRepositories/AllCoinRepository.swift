//
//  AllCoinRepository.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

protocol AllCoinRepositoryProtocol {
    func getAllCoin() async throws -> AllCoinResponse
}

class AllCoinRepository: AllCoinRepositoryProtocol {
    let allCoinRemoteDataSource: AllCoinRemoteDataSourceProtocol

    init(allCoinRemoteDataSource: AllCoinRemoteDataSourceProtocol = AllCoinRemoteDataSource()) {
        self.allCoinRemoteDataSource = allCoinRemoteDataSource
    }

    func getAllCoin() async throws -> AllCoinResponse {
        try await allCoinRemoteDataSource.getAllCoin()
    }
}
