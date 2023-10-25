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
        static let allCoinEndpoint = "top/mktcapfull?limit=%d&tsym=%@&page=%d&api_key=%@"
    }

    var path: String {
        switch self {
            case .allCoin(let limit, let toConvert, let page):
                return BaseEndpoint.base.path + String(format: Constants.allCoinEndpoint, limit, toConvert, page, Configuration.coinApiKey)
        }
    }
}