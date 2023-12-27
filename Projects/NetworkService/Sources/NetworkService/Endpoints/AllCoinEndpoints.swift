//
//  AllCoinEndpoints.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

enum AllCoinEndpoints: TargetEndpointProtocol {
    case allCoin(limit: Int, unitToBeConverted: String, page: Int)

    private struct Constants {
        static let allCoinEndpoint = "top/mktcapfull?limit=%d&tsym=%@&page=%d&api_key=%@"
    }

    var path: String {
        switch self {
            case .allCoin(let limit, let toConvert, let page):
                return BaseEndpoints.base.path + String(format: Constants.allCoinEndpoint, limit, toConvert, page, Configuration.coinApiKey)
        }
    }
}
