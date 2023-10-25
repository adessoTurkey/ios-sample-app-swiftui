//
//  FavoritesCoinRequest.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 18.05.2023.
//

import Foundation

struct FavoritesCoinRequest: Codable {
    let action: String
    var subs: [String]
}

extension FavoritesCoinRequest {
    init(action: SubscriptionRequestAction, codeList: [CoinCode], toChange: String = "USD") {
        self.action = action.rawValue
        self.subs = []
        codeList.forEach({ self.subs.append(Strings.coinPreRequest($0, toChange)) })
    }
}
