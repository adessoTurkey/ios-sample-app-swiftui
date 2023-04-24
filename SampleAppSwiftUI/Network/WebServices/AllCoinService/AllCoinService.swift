//
//  AllCoinService.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

protocol AllCoinServiceProtocol {
    func allCoinRequest() async throws -> AllCoinResponse
}

final class AllCoinService: AllCoinServiceProtocol, BaseServiceProtocol {

    typealias Endpoint = AllCoinServiceEndpoint

    let networkLoader: NetworkLoaderProtocol

    init(networkLoader: NetworkLoaderProtocol = NetworkLoaderProvider.shared.networkLoader) {
        self.networkLoader = networkLoader
    }

    func allCoinRequest() async throws -> AllCoinResponse {
        try await request(with: RequestObject(url: build(endpoint: .allCoin())),
                responseModel: AllCoinResponse.self)
    }
}
