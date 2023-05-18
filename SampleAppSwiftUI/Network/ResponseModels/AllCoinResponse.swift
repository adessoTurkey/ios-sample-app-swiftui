//
//  AllCoinResponse.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

// MARK: - AllCoinResponse
struct AllCoinResponse: Codable, Hashable, Identifiable {
    var id = UUID().uuidString
    let data: [CoinData]?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

// MARK: - Datum
struct CoinData: Codable, Hashable, Identifiable {
    var id = UUID().uuidString
    var coinInfo: CoinMarketCapsCoinInfo?
    var detail: CoinRaw?

    static func == (lhs: CoinData, rhs: CoinData) -> Bool {
        lhs.coinInfo == rhs.coinInfo &&
        lhs.detail == rhs.detail
    }

    enum CodingKeys: String, CodingKey {
        case coinInfo = "CoinInfo"
        case detail = "RAW"
    }

    static let demo = CoinData(coinInfo: CoinMarketCapsCoinInfo(code: "BTC", title: "Demo"),
                               detail: CoinRaw(usd: RawUsd(price: 29467.560,
                                                           changeAmount: 28.015,
                                                           changePercentage: 29.74)))
}

// MARK: - CoinInfo
struct CoinMarketCapsCoinInfo: Codable, Hashable {
    let code: CoinCode?
    var title: String?

    static func == (lhs: CoinMarketCapsCoinInfo, rhs: CoinMarketCapsCoinInfo) -> Bool {
        lhs.code == rhs.code
    }

    enum CodingKeys: String, CodingKey {
        case code = "Name"
        case title = "FullName"
    }
}

// MARK: - Raw
struct CoinRaw: Codable, Hashable {
    var usd: RawUsd?

    static func == (lhs: CoinRaw, rhs: CoinRaw) -> Bool {
        lhs.usd == rhs.usd
    }
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - RawUsd
struct RawUsd: Codable, Hashable {
    var price: Double?
    var changeAmount: Double?
    var changePercentage: Double?

    static func == (lhs: RawUsd, rhs: RawUsd) -> Bool {
        lhs.price == rhs.price &&
        lhs.changeAmount == rhs.changeAmount &&
        lhs.changePercentage == rhs.changePercentage
    }

    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case changeAmount = "OPENHOUR"
        case changePercentage = "CHANGEPCTHOUR"
    }
}
