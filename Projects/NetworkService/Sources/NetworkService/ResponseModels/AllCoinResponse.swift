//
//  AllCoinResponse.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

// MARK: - AllCoinResponse
public struct AllCoinResponse: Codable, Hashable, Identifiable {
    public var id = UUID().uuidString
    public let data: [CoinData]?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

// MARK: - CoinData
public struct CoinData: Codable, Hashable, Identifiable {
    public var id = UUID().uuidString
    public var coinInfo: CoinMarketCapsCoinInfo?
    public var detail: CoinRaw?

    public static func == (lhs: CoinData, rhs: CoinData) -> Bool {
        lhs.coinInfo == rhs.coinInfo &&
        lhs.detail == rhs.detail
    }

    enum CodingKeys: String, CodingKey {
        case coinInfo = "CoinInfo"
        case detail = "RAW"
    }

    public static let demo = CoinData(coinInfo: CoinMarketCapsCoinInfo(code: "BTC", title: "Demo"),
                               detail: CoinRaw(usd: RawUsd(price: 29467.560,
                                                           changeAmount: 28.015,
                                                           changePercentage: 29.74)))
}

// MARK: - CoinInfo
public struct CoinMarketCapsCoinInfo: Codable, Hashable {
    public let code: String?
    public var title: String?

    public static func == (lhs: CoinMarketCapsCoinInfo, rhs: CoinMarketCapsCoinInfo) -> Bool {
        lhs.code == rhs.code
    }

    enum CodingKeys: String, CodingKey {
        case code = "Name"
        case title = "FullName"
    }
}

// MARK: - CoinRaw
public struct CoinRaw: Codable, Hashable {
    public var usd: RawUsd?

    public static func == (lhs: CoinRaw, rhs: CoinRaw) -> Bool {
        lhs.usd == rhs.usd
    }

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - RawUsd
public struct RawUsd: Codable, Hashable {
    public var price: Double?
    public var changeAmount: Double?
    public var changePercentage: Double?

    public static func == (lhs: RawUsd, rhs: RawUsd) -> Bool {
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
