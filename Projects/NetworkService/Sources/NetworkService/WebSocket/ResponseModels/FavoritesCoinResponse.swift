//
//  FavoritesCoinResponse.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 18.05.2023.
//

import Foundation

public struct FavoritesCoinResponse: Codable {
    public let code: String?
    public let price: Double?
    public let lowestToday: Double?

    enum CodingKeys: String, CodingKey {
        case code = "FROMSYMBOL"
        case price = "PRICE"
        case lowestToday = "LOW24HOUR"
    }
}
