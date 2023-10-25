//
//  WebSocketMessageProtocol.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 22.02.2023.
//

import Foundation

protocol WebSocketMessageProtocol: Codable {
    var type: WebSocketMessageType { get set }
    var apiKey: String { get set}
    var dataType: [SubscribeDataType] { get set}
    var filterAsset: [CoinAssetType] { get set}
}

enum WebSocketMessageType: String, Codable {
    case hello
    case trade
    case exchange
}

enum SubscribeDataType: String, Codable {
/// Exchange rate updates (VWAP-24H)
    case exrate

/// Quote updates feed (order book level 1)
    case quote

/// Executed transactions feed (order book matches)
    case trade

/// Exchanges feed.
    case exchange
}

enum CoinAssetType: String, Codable {
    case BTC
    case ETH
    case BTCUSD = "BTC/USD"
}
