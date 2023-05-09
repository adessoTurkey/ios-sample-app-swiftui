//
//  WebSocketSubscriptionRequest.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 19.04.2023.
//

import Foundation

struct SubscriptionRequest: Codable {
    let action: String
    let subs: [String]
}

let sampleSubscriptionRequest = """
{
   "action": "SubAdd",
   "subs": ["5~CCCAGG~BTC~USD"]
}
"""

// MARK: - FavoritesCoinRequest
struct FavoritesCoinRequest: Codable {
    let action: String
    let subs: [String]
}

extension FavoritesCoinRequest {
    init(action: SubscriptionRequestAction, code: CoinCode, toChange: String = "USD") {
        self.action = action.rawValue
        self.subs = ["5~CCCAGG~\(code)~\(toChange)"]
    }
}

enum SubscriptionRequestAction: String {
    case add = "SubAdd"
    case remove = "SubRemove"
}

// MARK: FavoritesCoinResponse
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
