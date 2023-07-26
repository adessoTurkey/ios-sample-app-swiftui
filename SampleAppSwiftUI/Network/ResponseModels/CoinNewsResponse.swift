//
//  CoinNewsResponse.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 20.07.2023.
//

import Foundation

struct CoinNewsResponse: Codable, Hashable, Identifiable {
    var id = UUID()
    let type: Int
    let message: String
    let data: [CoinNewData]?
    let hasWarning: Bool

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case message = "Message"
        case data = "Data"
        case hasWarning = "HasWarning"
    }
}

// MARK: - Datum
struct CoinNewData: Codable, Hashable, Identifiable {
    let id: String
    let imageurl: String
    let title: String
    let url: String
    let body: String
    let source: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageurl, title, url, body
        case source
    }
}
