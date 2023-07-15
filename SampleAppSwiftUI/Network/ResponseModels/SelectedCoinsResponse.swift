//
//  SelectedCoinsResponse.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 15.07.2023.
//

import Foundation

// MARK: - SelectedCoinsResponse
struct SelectedCoinsResponse: Codable {
    let raw: [String: CoinRaw]?

    enum CodingKeys: String, CodingKey {
        case raw = "RAW"
    }

    func convert() -> [CoinData] {
        guard let raw = raw else {
            return []
        }
        var data = [CoinData]()
        for element in raw.keys {
            data.append(CoinData(coinInfo: CoinMarketCapsCoinInfo(code: element, title: "Demo"),
                                detail: raw[element]))
        }
        return data
    }
}
