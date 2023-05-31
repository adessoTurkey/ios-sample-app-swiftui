//
//  CoinPriceHistoryResponse.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 29.05.2023.
//

import Foundation

struct CoinPriceHistoryResponse: Codable {
    let data: CoinPriceHistoryData?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

struct CoinPriceHistoryData: Codable {
    let aggregated: Bool?
    let timeFrom: TimeInterval?
    let timeTo: TimeInterval?
    let data: [CoinPriceInfo]?

    enum CodingKeys: String, CodingKey {
        case aggregated = "Aggregated"
        case timeFrom = "TimeFrom"
        case timeTo = "TimeTo"
        case data = "Data"
    }
}

struct CoinPriceInfo: Codable {
    let time: TimeInterval?
    let high: Float?
    let low: Float?
    let open: Float?
    let volumeFrom: Float?
    let volumeTo: Float?
    let close: Float?

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
