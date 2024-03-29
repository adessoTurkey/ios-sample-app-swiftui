//
//  CodableExtensions.swift
//  SampleAppSwiftUI
//
//  Created by Alver, Tunay on 5.04.2023.
//

import Foundation

public extension Encodable {
    func encode() -> Data? {
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .deferredToData
        return try? encoder.encode(self)
    }

    func encode() -> String? {
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .deferredToData
        if let jsonData = try? encoder.encode(self) {
            return String(data: jsonData, encoding: .utf8)
        }
        return nil
    }
}

public extension Decodable {
    static func decode(_ data: Data) -> Self? {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .deferredToData
        return try? decoder.decode(self, from: data)
    }

    static func decode(_ data: String) -> Self? {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .deferredToData
        return try? decoder.decode(self, from: Data(data.utf8))
    }
}
