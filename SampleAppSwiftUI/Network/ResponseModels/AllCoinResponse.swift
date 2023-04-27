//
//  AllCoinResponse.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

// MARK: - AllCoinResponse
struct AllCoinResponse: Codable {
    let data: [CoinData]?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
    
    func convertToCoinInfoArray() -> [CoinInfo] {
        guard let data else { return [] }
        
        var coinList = [CoinInfo]()
        for coin in data {
            coinList.append(coin.convertToCoinInfo())
        }
        return coinList
    }
}

// MARK: - Datum
struct CoinData: Codable {
    let coinInfo: CoinMarketCapsCoinInfo?
    let raw: CoinRaw?

    enum CodingKeys: String, CodingKey {
        case coinInfo = "CoinInfo"
        case raw = "RAW"
    }
    
    func convertToCoinInfo() -> CoinInfo {
        guard let coin = coinInfo,
              let coinRaw = raw?.usd,
              let coinName = coin.fullName,
              let coinCode = coin.name,
              let coinChangePercentage = coinRaw.changepcthour,
              let coinChangeAmount = coinRaw.openhour,
              let coinPrice = coinRaw.price else { return .demo }
        
        return CoinInfo(title: coinName,
                        code: coinCode,
                        price: coinPrice,
                        changePercentage: coinChangePercentage,
                        changeAmount: coinChangeAmount)
    }
}

// MARK: - CoinInfo
struct CoinMarketCapsCoinInfo: Codable {
    let name: String?
    let fullName: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case fullName = "FullName"
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
    let openhour: Double?
    let changepcthour: Double?
    
    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case openhour = "OPENHOUR"
        case changepcthour = "CHANGEPCTHOUR"
    }
}
