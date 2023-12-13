//
//  FavoritesCoinResponse.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 18.05.2023.
//

import Foundation

struct FavoritesCoinResponse: Codable {
    let code: String?
    let price: Double?
    let lowestToday: Double?

    enum CodingKeys: String, CodingKey {
        case code = "FROMSYMBOL"
        case price = "PRICE"
        case lowestToday = "LOW24HOUR"
    }
}
