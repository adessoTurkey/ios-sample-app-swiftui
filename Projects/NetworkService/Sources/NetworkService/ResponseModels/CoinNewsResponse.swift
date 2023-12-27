//
//  CoinNewsResponse.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 20.07.2023.
//

import Foundation

public struct CoinNewsResponse: Codable, Hashable, Identifiable {
    public var id = UUID()
    public let type: Int
    public let message: String
    public let data: [CoinNewData]?
    public let hasWarning: Bool

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case message = "Message"
        case data = "Data"
        case hasWarning = "HasWarning"
    }
}

// MARK: - Datum
public struct CoinNewData: Codable, Hashable, Identifiable {
    public let id: String
    public let imageurl: String
    public let title: String
    public let url: String
    public let body: String
    public let source: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageurl, title, url, body
        case source
    }
}
