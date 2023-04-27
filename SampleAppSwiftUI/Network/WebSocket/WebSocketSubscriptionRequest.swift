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

let SampleSubscriptionRequest = """
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




// MARK: - FavoritesCoinResponse
struct FavoritesCoinResponse: Codable {
    let price: Double?

    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
    }
}
