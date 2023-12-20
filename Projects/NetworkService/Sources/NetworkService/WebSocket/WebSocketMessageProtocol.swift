//
//  WebSocketMessageProtocol.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 22.02.2023.
//

import Foundation

public protocol WebSocketMessageProtocol: Codable {
    var type: WebSocketMessageType { get set }
    var apiKey: String { get set}
    var dataType: [SubscribeDataType] { get set}
    var filterAsset: [CoinAssetType] { get set}
}

public enum WebSocketMessageType: String, Codable {
    case hello
    case trade
    case exchange
}

public enum SubscribeDataType: String, Codable {
/// Exchange rate updates (VWAP-24H)
    case exrate

/// Quote updates feed (order book level 1)
    case quote

/// Executed transactions feed (order book matches)
    case trade

/// Exchanges feed.
    case exchange
}

public enum CoinAssetType: String, Codable {
    case BTC
    case ETH
    case BTCUSD = "BTC/USD"
}
