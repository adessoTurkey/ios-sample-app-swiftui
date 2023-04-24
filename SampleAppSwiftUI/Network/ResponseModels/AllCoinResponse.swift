//
//  AllCoinResponse.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 24.04.2023.
//

import Foundation

// MARK: - AllCoinResponse
struct AllCoinResponse: Codable {
    let message: String?
    let type: Int?
    let metaData: MetaData?
    let sponsoredData: [String]?
    let data: [Datum]?
    let rateLimit: RateLimit?
    let hasWarning: Bool?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case type = "Type"
        case metaData = "MetaData"
        case sponsoredData = "SponsoredData"
        case data = "Data"
        case rateLimit = "RateLimit"
        case hasWarning = "HasWarning"
    }
    
    func contvertToCoinInfo() -> [CoinInfo] {
        guard let data else { return [] }
        
        var coinList = [CoinInfo]()
        for coin in data {
            coinList.append(coin.contvertToCoinInfo())
        }
        return coinList
    }
}

// MARK: - Datum
struct Datum: Codable {
    let coinInfo: CoinMarketCapsCoinInfo?
    let raw: Raw?
    let display: Display?

    enum CodingKeys: String, CodingKey {
        case coinInfo = "CoinInfo"
        case raw = "RAW"
        case display = "DISPLAY"
    }
    
    func contvertToCoinInfo() -> CoinInfo {
        guard let coin = coinInfo,
              let coinName = coin.fullName,
              let coinCode = coin.name,
              let coinChangePercentage = raw?.usd?.changepcthour,
              let coinChangeAmount = raw?.usd?.openhour,
              let coinPrice = raw?.usd?.price else { return .demo }
        
        return CoinInfo(title: coinName,
                                code: coinCode,
                                price: coinPrice,
                                changePercentage: coinChangePercentage,
                                changeAmount: coinChangeAmount)
    }
}

// MARK: - CoinInfo
struct CoinMarketCapsCoinInfo: Codable {
    let id, name, fullName, coinInfoInternal: String?
    let imageURL, url, algorithm, proofType: String?
    let rating: Rating?
    let netHashesPerSecond: Double?
    let blockNumber: Int?
    let blockTime, blockReward: Double?
    let assetLaunchDate: String?
    let maxSupply: Double?
    let type: Int?
    let documentType: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case fullName = "FullName"
        case coinInfoInternal = "Internal"
        case imageURL = "ImageUrl"
        case url = "Url"
        case algorithm = "Algorithm"
        case proofType = "ProofType"
        case rating = "Rating"
        case netHashesPerSecond = "NetHashesPerSecond"
        case blockNumber = "BlockNumber"
        case blockTime = "BlockTime"
        case blockReward = "BlockReward"
        case assetLaunchDate = "AssetLaunchDate"
        case maxSupply = "MaxSupply"
        case type = "Type"
        case documentType = "DocumentType"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let weiss: Weiss?

    enum CodingKeys: String, CodingKey {
        case weiss = "Weiss"
    }
}

// MARK: - Weiss
struct Weiss: Codable {
    let rating, technologyAdoptionRating, marketPerformanceRating: String?

    enum CodingKeys: String, CodingKey {
        case rating = "Rating"
        case technologyAdoptionRating = "TechnologyAdoptionRating"
        case marketPerformanceRating = "MarketPerformanceRating"
    }
}

// MARK: - Display
struct Display: Codable {
    let usd: DisplayUsd?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - DisplayUsd
struct DisplayUsd: Codable {
    let fromsymbol, tosymbol, market, price: String?
    let lastupdate, lastvolume, lastvolumeto, lasttradeid: String?
    let volumeday, volumedayto, volume24Hour, volume24Hourto: String?
    let openday, highday, lowday, open24Hour: String?
    let high24Hour, low24Hour, lastmarket, volumehour: String?
    let volumehourto, openhour, highhour, lowhour: String?
    let toptiervolume24Hour, toptiervolume24Hourto, change24Hour, changepct24Hour: String?
    let changeday, changepctday, changehour, changepcthour: String?
    let conversiontype, conversionsymbol, conversionlastupdate, supply: String?
    let mktcap, mktcappenalty, circulatingsupply, circulatingsupplymktcap: String?
    let totalvolume24H, totalvolume24Hto, totaltoptiervolume24H, totaltoptiervolume24Hto: String?
    let imageurl: String?

    enum CodingKeys: String, CodingKey {
        case fromsymbol = "FROMSYMBOL"
        case tosymbol = "TOSYMBOL"
        case market = "MARKET"
        case price = "PRICE"
        case lastupdate = "LASTUPDATE"
        case lastvolume = "LASTVOLUME"
        case lastvolumeto = "LASTVOLUMETO"
        case lasttradeid = "LASTTRADEID"
        case volumeday = "VOLUMEDAY"
        case volumedayto = "VOLUMEDAYTO"
        case volume24Hour = "VOLUME24HOUR"
        case volume24Hourto = "VOLUME24HOURTO"
        case openday = "OPENDAY"
        case highday = "HIGHDAY"
        case lowday = "LOWDAY"
        case open24Hour = "OPEN24HOUR"
        case high24Hour = "HIGH24HOUR"
        case low24Hour = "LOW24HOUR"
        case lastmarket = "LASTMARKET"
        case volumehour = "VOLUMEHOUR"
        case volumehourto = "VOLUMEHOURTO"
        case openhour = "OPENHOUR"
        case highhour = "HIGHHOUR"
        case lowhour = "LOWHOUR"
        case toptiervolume24Hour = "TOPTIERVOLUME24HOUR"
        case toptiervolume24Hourto = "TOPTIERVOLUME24HOURTO"
        case change24Hour = "CHANGE24HOUR"
        case changepct24Hour = "CHANGEPCT24HOUR"
        case changeday = "CHANGEDAY"
        case changepctday = "CHANGEPCTDAY"
        case changehour = "CHANGEHOUR"
        case changepcthour = "CHANGEPCTHOUR"
        case conversiontype = "CONVERSIONTYPE"
        case conversionsymbol = "CONVERSIONSYMBOL"
        case conversionlastupdate = "CONVERSIONLASTUPDATE"
        case supply = "SUPPLY"
        case mktcap = "MKTCAP"
        case mktcappenalty = "MKTCAPPENALTY"
        case circulatingsupply = "CIRCULATINGSUPPLY"
        case circulatingsupplymktcap = "CIRCULATINGSUPPLYMKTCAP"
        case totalvolume24H = "TOTALVOLUME24H"
        case totalvolume24Hto = "TOTALVOLUME24HTO"
        case totaltoptiervolume24H = "TOTALTOPTIERVOLUME24H"
        case totaltoptiervolume24Hto = "TOTALTOPTIERVOLUME24HTO"
        case imageurl = "IMAGEURL"
    }
}

// MARK: - Raw
struct Raw: Codable {
    let usd: RawUsd?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - RawUsd
struct RawUsd: Codable {
    let type, market, fromsymbol, tosymbol: String?
    let flags: String?
    let price: Double?
    let lastupdate: Int?
    let median, lastvolume, lastvolumeto: Double?
    let lasttradeid: String?
    let volumeday, volumedayto, volume24Hour, volume24Hourto: Double?
    let openday, highday, lowday, open24Hour: Double?
    let high24Hour, low24Hour: Double?
    let lastmarket: String?
    let volumehour, volumehourto, openhour, highhour: Double?
    let lowhour, toptiervolume24Hour, toptiervolume24Hourto, change24Hour: Double?
    let changepct24Hour, changeday, changepctday, changehour: Double?
    let changepcthour: Double?
    let conversiontype, conversionsymbol: String?
    let conversionlastupdate: Int?
    let supply, mktcap: Double?
    let mktcappenalty: Int?
    let circulatingsupply, circulatingsupplymktcap, totalvolume24H, totalvolume24Hto: Double?
    let totaltoptiervolume24H, totaltoptiervolume24Hto: Double?
    let imageurl: String?

    enum CodingKeys: String, CodingKey {
        case type = "TYPE"
        case market = "MARKET"
        case fromsymbol = "FROMSYMBOL"
        case tosymbol = "TOSYMBOL"
        case flags = "FLAGS"
        case price = "PRICE"
        case lastupdate = "LASTUPDATE"
        case median = "MEDIAN"
        case lastvolume = "LASTVOLUME"
        case lastvolumeto = "LASTVOLUMETO"
        case lasttradeid = "LASTTRADEID"
        case volumeday = "VOLUMEDAY"
        case volumedayto = "VOLUMEDAYTO"
        case volume24Hour = "VOLUME24HOUR"
        case volume24Hourto = "VOLUME24HOURTO"
        case openday = "OPENDAY"
        case highday = "HIGHDAY"
        case lowday = "LOWDAY"
        case open24Hour = "OPEN24HOUR"
        case high24Hour = "HIGH24HOUR"
        case low24Hour = "LOW24HOUR"
        case lastmarket = "LASTMARKET"
        case volumehour = "VOLUMEHOUR"
        case volumehourto = "VOLUMEHOURTO"
        case openhour = "OPENHOUR"
        case highhour = "HIGHHOUR"
        case lowhour = "LOWHOUR"
        case toptiervolume24Hour = "TOPTIERVOLUME24HOUR"
        case toptiervolume24Hourto = "TOPTIERVOLUME24HOURTO"
        case change24Hour = "CHANGE24HOUR"
        case changepct24Hour = "CHANGEPCT24HOUR"
        case changeday = "CHANGEDAY"
        case changepctday = "CHANGEPCTDAY"
        case changehour = "CHANGEHOUR"
        case changepcthour = "CHANGEPCTHOUR"
        case conversiontype = "CONVERSIONTYPE"
        case conversionsymbol = "CONVERSIONSYMBOL"
        case conversionlastupdate = "CONVERSIONLASTUPDATE"
        case supply = "SUPPLY"
        case mktcap = "MKTCAP"
        case mktcappenalty = "MKTCAPPENALTY"
        case circulatingsupply = "CIRCULATINGSUPPLY"
        case circulatingsupplymktcap = "CIRCULATINGSUPPLYMKTCAP"
        case totalvolume24H = "TOTALVOLUME24H"
        case totalvolume24Hto = "TOTALVOLUME24HTO"
        case totaltoptiervolume24H = "TOTALTOPTIERVOLUME24H"
        case totaltoptiervolume24Hto = "TOTALTOPTIERVOLUME24HTO"
        case imageurl = "IMAGEURL"
    }
}

// MARK: - MetaData
struct MetaData: Codable {
    let count: Int?

    enum CodingKeys: String, CodingKey {
        case count = "Count"
    }
}

// MARK: - RateLimit
struct RateLimit: Codable {
}
