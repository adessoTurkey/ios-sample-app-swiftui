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
    let coinInfo: CoinMarketCapsCoinInfo?
    let detail: CoinRaw?

    enum CodingKeys: String, CodingKey {
        case coinInfo = "CoinInfo"
        case detail = "RAW"
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: CoinData, rhs: CoinData) -> Bool {
        lhs.coinInfo?.code == rhs.coinInfo?.code
    }
    
    static let demo = CoinData(coinInfo: CoinMarketCapsCoinInfo(code: "BTC", title: "Demo"),
                               detail: CoinRaw(usd: RawUsd(price: 29467.560,
                                                           changeAmount: 28.015,
                                                           changePercentage: 29.74)))
}

// MARK: - CoinInfo
struct CoinMarketCapsCoinInfo: Codable {
    let code: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case code = "Name"
        case title = "FullName"
    }
}

// MARK: - Raw
struct CoinRaw: Codable {
    let usd: RawUsd?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - RawUsd
struct RawUsd: Codable {
    let price: Double?
    let changeAmount: Double?
    let changePercentage: Double?
    
    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case changeAmount = "OPENHOUR"
        case changePercentage = "CHANGEPCTHOUR"
    }
}
