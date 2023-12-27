//
//  AllCoinRequestModel.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

public struct AllCoinRequestModel: Encodable {
    let limit: Int
    let unitToBeConverted: String
    let page: Int

    public init(limit: Int = 3,
                unitToBeConverted: String = "USD",
                page: Int = 1) {
        self.limit = limit
        self.unitToBeConverted = unitToBeConverted
        self.page = page
    }

    enum CodingKeys: String, CodingKey {
        case limit = "limit"
        case unitToBeConverted = "unitToBeConverted"
        case page = "page"
    }
}
