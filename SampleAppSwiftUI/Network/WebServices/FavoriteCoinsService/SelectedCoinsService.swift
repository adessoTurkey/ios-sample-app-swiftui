//
//  SelectedCoinsService.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 15.07.2023.
//

import Foundation

protocol SelectedCoinsServiceProtocol {
    func selectedCoinsRequest(_ selectedCoins: [CoinCode], unit: String) async throws -> SelectedCoinsResponse
}

final class SelectedCoinsService: SelectedCoinsServiceProtocol, BaseServiceProtocol {

    typealias Endpoint = SelectedCoinsServiceEndpoint

    let networkLoader: NetworkLoaderProtocol

    init(networkLoader: NetworkLoaderProtocol = NetworkLoaderProvider.shared.networkLoader) {
        self.networkLoader = networkLoader
    }

    func selectedCoinsRequest(_ selectedCoins: [CoinCode], unit: String = "USD") async throws -> SelectedCoinsResponse {
        try await request(with: RequestObject(url: build(endpoint: .selectedCoins(selectedCoins, unitToBeConverted: unit))), responseModel: SelectedCoinsResponse.self)
    }
}
