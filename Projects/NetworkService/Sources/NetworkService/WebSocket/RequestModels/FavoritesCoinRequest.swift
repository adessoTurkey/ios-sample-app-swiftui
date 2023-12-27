//
//  FavoritesCoinRequest.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 18.05.2023.
//

import Foundation

public struct FavoritesCoinRequest: Codable {
    public let action: String
    public var subs: [String]
}

public extension FavoritesCoinRequest {
    init(action: SubscriptionRequestAction, codeList: [String], toChange: String = "USD") {
        self.action = action.rawValue
        self.subs = []
        codeList.forEach({ self.subs.append(String(format: String(localized: "CoinPreRequest"), $0, toChange)) })
    }
}
