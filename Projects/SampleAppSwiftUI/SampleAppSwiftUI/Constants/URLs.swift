//
//  URLs.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 3.04.2023.
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
