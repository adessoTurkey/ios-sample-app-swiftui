//
//  CoinNewsEndpoints.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

enum CoinNewsEndpoints: TargetEndpointProtocol {

    case coinNews(coinCode: String)

    private struct Constants {
        static let coinNewsEndpoint = "v2/news/?categories=%@&api_key=%@"
    }

    var path: String {
        switch self {
            case .coinNews(coinCode: let coinCode):
                return BaseEndpoints.base.path + String(format: Constants.coinNewsEndpoint, coinCode, Configuration.coinApiKey)
        }
    }
}
