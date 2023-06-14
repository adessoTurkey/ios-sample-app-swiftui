//
//  URLs.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 3.04.2023.
//

import Foundation

enum URLs {
    enum Icons {
        static let baseURL = "https://assets.coincap.io/assets/icons/"
        static let scaleURL = "@2x.png"

        static func getURL(from coinCode: CoinCode) -> URL? {
            URL(string: "\(baseURL)\(coinCode.lowercased())\(scaleURL)")
        }
    }
}
