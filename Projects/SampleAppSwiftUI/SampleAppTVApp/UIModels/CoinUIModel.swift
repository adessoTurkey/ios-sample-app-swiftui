//
//  CoinUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService
import SwiftData


struct CoinUIModel: Codable, Hashable, Identifiable {
    var id: String
    var coinInfo: CoinMarketCapsCoinInfoUIModel?
    var detail: CoinRawUIModel?

    init(id: String, coinInfo: CoinMarketCapsCoinInfoUIModel? = nil, detail: CoinRawUIModel? = nil) {
        self.id = id
        self.coinInfo = coinInfo
        self.detail = detail
    }

    static func == (lhs: CoinUIModel, rhs: CoinUIModel) -> Bool {
        lhs.coinInfo == rhs.coinInfo &&
        lhs.detail == rhs.detail
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        coinInfo = try values.decode(CoinMarketCapsCoinInfoUIModel.self, forKey: .coinInfo)
        detail = try values.decode(CoinRawUIModel.self, forKey: .detail)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(coinInfo, forKey: .coinInfo)
        try container.encodeIfPresent(detail, forKey: .detail)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case coinInfo
        case detail
    }
}

// MARK: - UIModelProtocol

extension CoinUIModel: UIModelProtocol {
    init(from responseModel: CoinData) {
        self.id = responseModel.id
        self.coinInfo = CoinMarketCapsCoinInfoUIModel(from: responseModel.coinInfo)
        self.detail = CoinRawUIModel(from: responseModel.detail)
    }

    init?(from responseModel: CoinData?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}

// MARK: - DEMO
extension CoinUIModel {
    static let demo = CoinUIModel(id: UUID().uuidString,
                                  coinInfo: CoinMarketCapsCoinInfoUIModel(code: "BTC", title: "Demo"),
                                  detail: CoinRawUIModel(usd: RawUsdUIModel(price: 29467.560,
                                                                changeAmount: 28.015,
                                                                changePercentage: 29.74)))
}
