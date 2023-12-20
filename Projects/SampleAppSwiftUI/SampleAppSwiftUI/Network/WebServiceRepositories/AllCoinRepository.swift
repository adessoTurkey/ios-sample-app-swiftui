//
//  AllCoinRepository.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation
import NetworkService

protocol AllCoinRepositoryProtocol {
    func getAllCoin(limit: Int, unitToBeConverted: String, page: Int) async throws -> AllCoinResponse
}

class AllCoinRepository: AllCoinRepositoryProtocol {
    let allCoinRemoteDataSource: AllCoinRemoteDataSourceProtocol

    init(allCoinRemoteDataSource: AllCoinRemoteDataSourceProtocol = AllCoinRemoteDataSource()) {
        self.allCoinRemoteDataSource = allCoinRemoteDataSource
    }

    func getAllCoin(limit: Int, unitToBeConverted: String, page: Int) async throws -> AllCoinResponse {
        try await allCoinRemoteDataSource.getAllCoin(limit: limit, unitToBeConverted: unitToBeConverted, page: page)
    }
}
