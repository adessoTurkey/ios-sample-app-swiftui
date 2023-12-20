//
//  CoinPriceHistoryEndpoints.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

enum CoinPriceHistoryEndpoints: TargetEndpointProtocol {
    case daily(coinCode: String, unitToBeConverted: String, dayLimit: Int, aggregate: Int)
    case hourly(coinCode: String, unitToBeConverted: String, hourLimit: Int, aggregate: Int)

    private struct Constants {
        static let dailyEndpoint = "v2/histoday?fsym=%@&tsym=%@&limit=%d&aggregate=%d&api_key=%@"
        static let hourlyEndpoint = "v2/histohour?fsym=%@&tsym=%@&limit=%d&aggregate=%d&api_key=%@"
    }

    var path: String {
        switch self {
            case .daily(let coinCode, let unitToBeConverted, let dayLimit, let aggregate):
                return BaseEndpoints.base.path + String(format: Constants.dailyEndpoint, coinCode, unitToBeConverted, dayLimit, aggregate, Configuration.coinApiKey)
            case .hourly(let coinCode, let unitToBeConverted, let hourLimit, let aggregate):
                return BaseEndpoints.base.path + String(format: Constants.hourlyEndpoint, coinCode, unitToBeConverted, hourLimit, aggregate, Configuration.coinApiKey)
        }
    }
}
