//
//  CoinPriceHistoryResponse.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 29.05.2023.
//

import Foundation

public struct CoinPriceHistoryResponse: Codable {
    public let data: CoinPriceHistoryData?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

public struct CoinPriceHistoryData: Codable {
    public let aggregated: Bool?
    public let timeFrom: TimeInterval?
    public let timeTo: TimeInterval?
    public let data: [CoinPriceInfo]?

    enum CodingKeys: String, CodingKey {
        case aggregated = "Aggregated"
        case timeFrom = "TimeFrom"
        case timeTo = "TimeTo"
        case data = "Data"
    }
}

public struct CoinPriceInfo: Codable {
    public let time: TimeInterval?
    public let high: Float?
    public let low: Float?
    public let open: Float?
    public let volumeFrom: Float?
    public let volumeTo: Float?
    public let close: Float?

    enum CodingKeys: String, CodingKey {
        case time
        case high
        case low
        case open
        case volumeFrom = "volumefrom"
        case volumeTo = "volumeto"
        case close
    }
}
