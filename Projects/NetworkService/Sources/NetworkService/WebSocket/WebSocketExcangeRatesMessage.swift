//
//  WebSocketExcangeRatesMessage.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 1.03.2023.
//

import Foundation

public struct WebSocketExcangeRatesMessage: WebSocketMessageProtocol {

    public var type: WebSocketMessageType
    public var apiKey: String = Configuration.coinApiKey
    public var heartbeat: Bool
    public var dataType: [SubscribeDataType]
    public var filterAsset: [CoinAssetType]
    public var delayTime: Int = 3000

    init(type: WebSocketMessageType = .hello,
         heartbeat: Bool = false,
         dataType: [SubscribeDataType] = [.exrate],
         filterAsset: [CoinAssetType] = [.BTCUSD]) {
        self.type = type
        self.heartbeat = heartbeat
        self.dataType = dataType
        self.filterAsset = filterAsset
    }

    private enum CodingKeys: String, CodingKey {
        case type
        case apiKey = "apikey"
        case heartbeat
        case dataType = "subscribe_data_type"
        case filterAsset = "subscribe_filter_asset_id"
        case delayTime = "subscribe_update_limit_ms_exrate"
    }
}

public struct ExcangeRatesResponseModel: Codable, Identifiable, ResponseModelProtocol {
    public var id: String {
        coinName()
    }
    public let time, assetIDBase, assetIDQuote, rateType: String
    public let rate: Double
    public let type: String

    enum CodingKeys: String, CodingKey {
        case time
        case assetIDBase = "asset_id_base"
        case assetIDQuote = "asset_id_quote"
        case rateType = "rate_type"
        case rate, type
    }

    public func formattedPrice() -> String {
        "\(Int(rate))"
    }

    public func coinName() -> String {
        "\(assetIDBase)/\(self.assetIDQuote)"
    }
}

public protocol ResponseModelProtocol {}
