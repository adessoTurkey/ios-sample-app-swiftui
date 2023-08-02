//
//  AllCoinResponse.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

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
public class CoinData: NSObject, NSCoding, Codable, Identifiable {
    public var id = UUID().uuidString
    var coinInfo: CoinMarketCapsCoinInfo?
    var detail: CoinRaw?

    internal init(id: String = UUID().uuidString, coinInfo: CoinMarketCapsCoinInfo? = nil, detail: CoinRaw? = nil) {
        self.id = id
        self.coinInfo = coinInfo
        self.detail = detail
    }

    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(coinInfo, forKey: "coinInfo")
        coder.encode(detail, forKey: "detail")
    }

    required public init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: "id") as? String ?? UUID().uuidString
        self.coinInfo = coder.decodeObject(forKey: "coinInfo") as? CoinMarketCapsCoinInfo
        self.detail = coder.decodeObject(forKey: "detail") as? CoinRaw
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
class CoinMarketCapsCoinInfo: NSObject, NSCoding, Codable {
    let code: CoinCode?
    var title: String?

    internal init(code: CoinCode? = nil, title: String? = nil) {
        self.code = code
        self.title = title
    }

    func encode(with coder: NSCoder) {
        coder.encode(code, forKey: "code")
        coder.encode(title, forKey: "title")
    }

    required init?(coder: NSCoder) {
        self.code = coder.decodeObject(forKey: "code") as? CoinCode
        self.title = coder.decodeObject(forKey: "title") as? String
    }

    enum CodingKeys: String, CodingKey {
        case code = "Name"
        case title = "FullName"
    }
}

// MARK: - Raw
class CoinRaw: NSObject, NSCoding, Codable {
    var usd: RawUsd?

    internal init(usd: RawUsd? = nil) {
        self.usd = usd
    }

    func encode(with coder: NSCoder) {
        coder.encode(usd, forKey: "usd")
    }

    required init?(coder: NSCoder) {
        self.usd = coder.decodeObject(forKey: "usd") as? RawUsd
    }

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - RawUsd
class RawUsd: NSObject, NSCoding, Codable {
    var price: Double?
    var changeAmount: Double?
    var changePercentage: Double?

    internal init(price: Double? = nil, changeAmount: Double? = nil, changePercentage: Double? = nil) {
        self.price = price
        self.changeAmount = changeAmount
        self.changePercentage = changePercentage
    }

    func encode(with coder: NSCoder) {
        coder.encode(price, forKey: "price")
        coder.encode(changeAmount, forKey: "changeAmount")
        coder.encode(changePercentage, forKey: "changePercentage")
    }

    required init?(coder: NSCoder) {
        self.price = coder.decodeObject(forKey: "price") as? Double
        self.changeAmount = coder.decodeObject(forKey: "changeAmount") as? Double
        self.changePercentage = coder.decodeObject(forKey: "changePercentage") as? Double
    }

    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case changeAmount = "OPENHOUR"
        case changePercentage = "CHANGEPCTHOUR"
    }
}
