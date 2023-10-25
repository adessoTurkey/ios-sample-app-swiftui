//
//  CoinPriceHistoryServiceEndpoint.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 29.05.2023.
//

import Foundation

enum CoinPriceHistoryServiceEndpoint: TargetEndpointProtocol {
    case daily(coinCode: String, unitToBeConverted: String = "USD", dayLimit: Int = 30, aggregate: Int = 1)
    case hourly(coinCode: String, unitToBeConverted: String = "USD", hourLimit: Int = 30, aggregate: Int = 1)

    private struct Constants {
        static let dailyEndpoint = "v2/histoday?fsym=%@&tsym=%@&limit=%d&aggregate=%d&api_key=%@"
        static let hourlyEndpoint = "v2/histohour?fsym=%@&tsym=%@&limit=%d&aggregate=%d&api_key=%@"
    }

    var path: String {
        switch self {
            case .daily(let coinCode, let unitToBeConverted, let dayLimit, let aggregate):
                return BaseEndpoint.base.path + String(format: Constants.dailyEndpoint, coinCode, unitToBeConverted, dayLimit, aggregate, Configuration.coinApiKey)
            case .hourly(let coinCode, let unitToBeConverted, let hourLimit, let aggregate):
                return BaseEndpoint.base.path + String(format: Constants.hourlyEndpoint, coinCode, unitToBeConverted, hourLimit, aggregate, Configuration.coinApiKey)
        }
    }
}
