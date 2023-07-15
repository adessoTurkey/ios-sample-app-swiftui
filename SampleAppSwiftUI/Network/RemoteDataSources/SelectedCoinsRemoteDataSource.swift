//
//  FavoriteCoinRemoteDataSource.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 15.07.2023.
//

import Foundation

protocol SelectedCoinsRemoteDataSourceProtocol {
    func getSelectedCoins(_ selectedCoins: [CoinCode], unitToBeConverted: String) async throws -> SelectedCoinsResponse
}

class SelectedCoinsRemoteDataSource: SelectedCoinsRemoteDataSourceProtocol {

    let selectedCoinsService: SelectedCoinsServiceProtocol

    init(selectedCoinsService: SelectedCoinsServiceProtocol = WebServiceProvider.shared.selectedCoinsService) {
        self.selectedCoinsService = selectedCoinsService
    }

    func getSelectedCoins(_ selectedCoins: [CoinCode], unitToBeConverted: String = "USD") async throws -> SelectedCoinsResponse {
        try await selectedCoinsService.selectedCoinsRequest(selectedCoins, unit: unitToBeConverted)
    }
}
