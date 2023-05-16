//
//  AllCoinService.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

protocol AllCoinServiceProtocol {
    func allCoinRequest(limit: Int, unitToBeConverted: String, page: Int) async throws -> AllCoinResponse
}

final class AllCoinService: AllCoinServiceProtocol, BaseServiceProtocol {

    typealias Endpoint = AllCoinServiceEndpoint

    let networkLoader: NetworkLoaderProtocol

    init(networkLoader: NetworkLoaderProtocol = NetworkLoaderProvider.shared.networkLoader) {
        self.networkLoader = networkLoader
    }

    func allCoinRequest(limit: Int = 3, unitToBeConverted: String = "USD", page: Int = 1) async throws -> AllCoinResponse {
        try await request(with: RequestObject(url: build(endpoint: .allCoin(limit: limit, unitToBeConverted: unitToBeConverted, page: page))),
                responseModel: AllCoinResponse.self)
    }
}
