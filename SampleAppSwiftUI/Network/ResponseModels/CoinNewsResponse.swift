//
//  CoinNewsResponse.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 20.07.2023.
//

import Foundation

struct CoinNewsResponse: Codable {
    let type: Int
    let message: String
    let data: [Datum]
    let hasWarning: Bool

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case message = "Message"
        case data = "Data"
        case hasWarning = "HasWarning"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: String
    let guid: String
    let publishedOn: Int
    let imageurl: String
    let title: String
    let url: String
    let body, tags: String
    let upvotes, downvotes, categories: String
    let sourceInfo: SourceInfo
    let source: String

    enum CodingKeys: String, CodingKey {
        case id, guid
        case publishedOn = "published_on"
        case imageurl, title, url, body, tags, upvotes, downvotes, categories
        case sourceInfo = "source_info"
        case source
    }
}

// MARK: - SourceInfo
struct SourceInfo: Codable {
    let name: String
    let img: String
}
