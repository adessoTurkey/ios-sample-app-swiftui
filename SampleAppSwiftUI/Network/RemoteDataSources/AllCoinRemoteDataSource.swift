//
//  AllCoinRemoteDataSource.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

protocol AllCoinRemoteDataSourceProtocol {
    func getAllCoin() async throws -> AllCoinResponse
}

class AllCoinRemoteDataSource: AllCoinRemoteDataSourceProtocol {

    let allCoinService: AllCoinServiceProtocol

    init(allCoinService: AllCoinServiceProtocol = WebServiceProvider.shared.allCoinService) {
        self.allCoinService = allCoinService
    }

    func getAllCoin() async throws -> AllCoinResponse {
        try await allCoinService.allCoinRequest()
    }
}
