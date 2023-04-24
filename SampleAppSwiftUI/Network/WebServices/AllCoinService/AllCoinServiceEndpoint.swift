//
//  AllCoinServiceEndpoint.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

enum AllCoinServiceEndpoint: TargetEndpointProtocol {
    case allCoin(limit: Int = 3, unitToBeConverted: String = "USD")

    private struct Constants {
        static let allCoinEndpoint = "https://min-api.cryptocompare.com/data/top/mktcapfull?limit=3&tsym=USD"
    }

    var path: String {
        switch self {
        case .allCoin(let limit, let toConvert):
                return BaseEndpoint.base.path + String(format: Constants.allCoinEndpoint, limit, toConvert)
            }
    }
}
