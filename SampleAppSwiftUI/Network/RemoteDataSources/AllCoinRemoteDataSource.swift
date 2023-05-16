//
//  AllCoinRemoteDataSource.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

protocol AllCoinRemoteDataSourceProtocol {
    func getAllCoin(limit: Int, unitToBeConverted: String, page: Int) async throws -> AllCoinResponse
}

class AllCoinRemoteDataSource: AllCoinRemoteDataSourceProtocol {

    let allCoinService: AllCoinServiceProtocol

    init(allCoinService: AllCoinServiceProtocol = WebServiceProvider.shared.allCoinService) {
        self.allCoinService = allCoinService
    }

    func getAllCoin(limit: Int, unitToBeConverted: String, page: Int) async throws -> AllCoinResponse {
        try await allCoinService.allCoinRequest(limit: limit, unitToBeConverted: unitToBeConverted, page: page)
    }
}
