//
//  EncodableExtensions.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 22.02.2023.
//

import Foundation

public extension Encodable {

    func toJSONString() -> String? {
        guard let jsonData = try? JSONEncoder().encode(self) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}
