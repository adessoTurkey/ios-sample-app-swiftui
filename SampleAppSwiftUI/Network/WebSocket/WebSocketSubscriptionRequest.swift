//
//  WebSocketSubscriptionRequest.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 19.04.2023.
//

import Foundation

struct SubscriptionRequest: Codable {
    let action: String
    let subs: [String]
}

let sampleSubscriptionRequest = """
{
   "action": "SubAdd",
   "subs": ["5~CCCAGG~BTC~USD"]
}
"""

// MARK: - FavoritesCoinRequest
struct FavoritesCoinRequest: Codable {
    let action: String
    let subs: [String]
}

extension FavoritesCoinRequest {
    init(action: SubscriptionRequestAction, code: CoinCode, toChange: String = "USD") {
        self.action = action.rawValue
        self.subs = ["5~CCCAGG~\(code)~\(toChange)"]
    }
}

enum SubscriptionRequestAction: String {
    case add = "SubAdd"
    case remove = "SubRemove"
}

// MARK: FavoritesCoinResponse
struct FavoritesCoinResponse: Codable {
    let code: String?
    let price: Double?
    let lowestToday: Double?

    enum CodingKeys: String, CodingKey {
        case code = "FROMSYMBOL"
        case price = "PRICE"
        case lowestToday = "LOW24HOUR"
    }
}

//
//// MARK: - FavoritesCoinResponse
//struct FavoritesCoinResponse: Codable {
//    let type, market, fromsymbol, tosymbol: String?
//    let flags: Int?
//    let price: Double?
//    let lastupdate: Int?
//    let median, lastvolume, lastvolumeto: Double?
//    let lasttradeid: String?
//    let volumeday, volumedayto, volume24Hour, volume24Hourto: Double?
//    let lastmarket: String?
//    let volumehour, volumehourto, toptiervolume24Hour, toptiervolume24Hourto: Double?
//    let currentsupplymktcap, circulatingsupplymktcap: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case type = "TYPE"
//        case market = "MARKET"
//        case fromsymbol = "FROMSYMBOL"
//        case tosymbol = "TOSYMBOL"
//        case flags = "FLAGS"
//        case price = "PRICE"
//        case lastupdate = "LASTUPDATE"
//        case median = "MEDIAN"
//        case lastvolume = "LASTVOLUME"
//        case lastvolumeto = "LASTVOLUMETO"
//        case lasttradeid = "LASTTRADEID"
//        case volumeday = "VOLUMEDAY"
//        case volumedayto = "VOLUMEDAYTO"
//        case volume24Hour = "VOLUME24HOUR"
//        case volume24Hourto = "VOLUME24HOURTO"
//        case lastmarket = "LASTMARKET"
//        case volumehour = "VOLUMEHOUR"
//        case volumehourto = "VOLUMEHOURTO"
//        case toptiervolume24Hour = "TOPTIERVOLUME24HOUR"
//        case toptiervolume24Hourto = "TOPTIERVOLUME24HOURTO"
//        case currentsupplymktcap = "CURRENTSUPPLYMKTCAP"
//        case circulatingsupplymktcap = "CIRCULATINGSUPPLYMKTCAP"
//    }
//}
