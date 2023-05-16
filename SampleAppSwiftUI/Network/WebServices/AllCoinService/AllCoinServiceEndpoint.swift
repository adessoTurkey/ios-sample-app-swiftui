//
//  AllCoinServiceEndpoint.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

enum AllCoinServiceEndpoint: TargetEndpointProtocol {
    case allCoin(limit: Int = 3, unitToBeConverted: String = "USD", page: Int = 1)

    private struct Constants {
        static let allCoinEndpoint = Configuration.allCoinBaseUrl
    }

    var path: String {
        switch self {
            case .allCoin(let limit, let toConvert, let page):
                return String(format: Constants.allCoinEndpoint, limit, toConvert, page, Configuration.coinApiKey)
        }
    }
}
