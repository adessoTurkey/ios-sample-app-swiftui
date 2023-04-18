//
//  SubscriptionRequest.swift
//  SwiftUI_websocket_learning
//
//  Created by Uslu, Teyhan on 18.04.2023.
//

import Foundation

struct SubscriptionRequest: Codable {
    let action: String
    let subs: [String]
}



enum SubscriptionRequestAction: String, CodingKey, Codable {
    case subAdd
    case subRemove
    
    enum CodingKeys: String, CodingKey {
        case subAdd = "SubAdd"
        case subRemove = "SubRemove"
    }
}

struct DandikRequest: Codable {
    let action = "SubAdd"
    let subs = ["5~CCCAGG~BTC~USD", "0~Coinbase~ETH~USD", "2~Binance~BTC~USDT"]
}

let sampleReq = """
{
   "action": "SubAdd",
   "subs": ["0~Coinbase~BTC~USD"]
}
"""
