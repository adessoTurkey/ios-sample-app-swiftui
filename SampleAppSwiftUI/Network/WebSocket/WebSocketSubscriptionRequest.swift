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
   "subs": ["0~Coinbase~BTC~USD"]
}
"""
