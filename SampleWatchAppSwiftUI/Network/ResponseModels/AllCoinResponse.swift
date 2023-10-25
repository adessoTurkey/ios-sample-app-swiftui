//
//  AllCoinResponse.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation
import SwiftUI

typealias CoinCode = String

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
                                                           changePercentage: 24.2)))

    func getCoinPriceFormatted() -> String {
        let priceDouble = self.detail?.usd?.price ?? 0
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency

        guard
            let formattedPrice = formatter.string(from: priceDouble as NSNumber)
        else {
            return Strings.noData
        }

        return formattedPrice
    }

    func getPriceChangePercentageFormatted() -> String {
        let percentage = self.detail?.usd?.changePercentage ?? 0
        let percentageString = formatDoublePresicion(percentage) ?? "0"
        let changePrefix = percentage > 0 ? "+" : ""
        let formattedChangePercentage = changePrefix + percentageString

        return formattedChangePercentage
    }

    func getPriceChangeAmountFormatted() -> String {
        let changeAmount = self.detail?.usd?.changeAmount ?? 0
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        guard
            let formattedPrice = formatter.string(from: changeAmount as NSNumber)
        else {
            return Strings.noData
        }

        return formattedPrice
    }

    func getBackgroundColor() -> Color {
        let percentage = self.detail?.usd?.changePercentage ?? 0
        switch percentage {
            case let change where change > 0:
                return .coinCardBackgroundPositive
            case let change where change < 0:
                return .coinCardBackgroundNegative
            default:
                return .coindCardBackgroundNeutral
        }
    }

    func getTitleColor() -> Color {
        let percentage = self.detail?.usd?.changePercentage ?? 0
        switch percentage {
            case let change where change > 0:
                return .green
            case let change where change < 0:
                return .red
            default:
                return .gray
        }
    }

    private func formatDoublePresicion(_ value: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter.string(from: NSNumber(floatLiteral: value))
    }
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
        lhs.price == rhs.price
        && lhs.changeAmount == rhs.changeAmount
        && lhs.changePercentage == rhs.changePercentage
    }

    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case changeAmount = "OPENHOUR"
        case changePercentage = "CHANGEPCTHOUR"
    }
}
