//
//  AllCoinService.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

public protocol AllCoinServiceProtocol {
    func allCoinRequest(requestModel: AllCoinRequestModel) async throws -> AllCoinResponse
}

public final class AllCoinService: AllCoinServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = AllCoinEndpoints
    var networkLoader: NetworkLoaderProtocol

    public init(networkLoader: NetworkLoaderProtocol = NetworkLoader.shared){
        self.networkLoader = networkLoader
    }

    public func allCoinRequest(requestModel: AllCoinRequestModel) async throws -> AllCoinResponse {
        let urlString = build(endpoint: .allCoin(limit: requestModel.limit,
                                                 unitToBeConverted: requestModel.unitToBeConverted,
                                                 page: requestModel.page))

        return try await request(with: RequestObject(url: urlString), responseModel: AllCoinResponse.self)
    }
}
