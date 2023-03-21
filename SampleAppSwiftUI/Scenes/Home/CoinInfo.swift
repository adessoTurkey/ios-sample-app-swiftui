//
//  CoinInfo.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 21.03.2023.
//

import Foundation

struct CoinInfo: Hashable, Identifiable {
    var id = UUID().uuidString
    var imageName: String
    var title: String
    var code: String
    var price: String
    var changePercentage: String
    var changeAmount: String

    static let demo = CoinInfo(imageName: "btc", title: "Bitcoin", code: "BTC", price: "$29,467.560", changePercentage: "29.74%", changeAmount: "$28.015")
    static let secondDemo = CoinInfo(imageName: "binance", title: "Binance", code: "BNB", price: "$23,5", changePercentage: "-24%", changeAmount: "$28.0")
}
