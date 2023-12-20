//
//  CoinNewsRequestModel.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

public struct CoinNewsRequestModel: Encodable {
    let coinCode: String

    public init(coinCode: String) {
        self.coinCode = coinCode
    }

    enum CodingKeys: String, CodingKey {
        case coinCode = "coinCode"
    }
}
