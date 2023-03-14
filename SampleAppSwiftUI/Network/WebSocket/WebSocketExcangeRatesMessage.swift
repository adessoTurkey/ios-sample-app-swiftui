//
//  WebSocketExcangeRatesMessage.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 1.03.2023.
//

import Foundation

struct WebSocketExcangeRatesMessage: WebSocketMessageProtocol {

    var type: WebSocketMessageType
    var apiKey: String = Configuration.coinApiKey
    var heartbeat: Bool
    var dataType: [SubscribeDataType]
    var filterAsset: [CoinAssetType]
    var delayTime: Int = 3000

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

struct ExcangeRatesResponseModel: Codable, Identifiable, ResponseModelProtocol {
    var id: String {
        coinName()
    }
    let time, assetIDBase, assetIDQuote, rateType: String
    let rate: Double
    let type: String

    enum CodingKeys: String, CodingKey {
        case time
        case assetIDBase = "asset_id_base"
        case assetIDQuote = "asset_id_quote"
        case rateType = "rate_type"
        case rate, type
    }
    
    func formattedPrice() -> String {
        "\(Int(rate))"
    }
    
    func coinName()  -> String {
        "\(assetIDBase)/\(self.assetIDQuote)"
    }
}
protocol ResponseModelProtocol {}
