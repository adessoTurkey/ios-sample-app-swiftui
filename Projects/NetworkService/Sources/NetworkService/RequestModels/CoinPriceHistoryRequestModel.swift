//
//  CoinPriceHistoryRequestModel.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

public struct CoinPriceHistoryRequestModel: Encodable {
    let coinCode: String
    let unitToBeConverted: String
    let limit: Int
    let aggregate: Int

    public init(coinCode: String,
                unitToBeConverted: String = "USD",
                limit: Int = 30,
                aggregate: Int = 1) {
        self.coinCode = coinCode
        self.unitToBeConverted = unitToBeConverted
        self.limit = limit
        self.aggregate = aggregate
    }

    enum CodingKeys: String, CodingKey {
        case coinCode = "coinCode"
        case unitToBeConverted = "unitToBeConverted"
        case limit = "limit"
        case aggregate = "aggregate"
    }
}
