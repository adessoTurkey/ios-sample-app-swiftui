//
//  URLs.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 28.12.2023.
//

import Foundation

enum URLs {
    enum Icons {
        static let baseURL = "https://assets.coincap.io"
        static let iconPath = "/assets/icons/"
        static let scaleURL = "@2x.png"

        static func getURL(from coinCode: String) -> URL? {
            URL(string: "\(baseURL)\(iconPath)\(coinCode.lowercased())\(scaleURL)")
        }
    }
}
