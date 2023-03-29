//
//  CoinInfo.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 21.03.2023.
//

import Foundation

struct CoinInfo: Codable, Hashable, Identifiable {
    var id = UUID().uuidString
    var title: String
    var code: String
    var price: Double
    var changePercentage: Double
    var changeAmount: Double

    static let demo = CoinInfo(title: "Bitcoin", code: "BTC", price: 29467.560, changePercentage: 29.74, changeAmount: 28.015)
}
