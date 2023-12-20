//
//  ExampleRequestModel.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

public struct ExampleRequestModel: Encodable {
    let firstParameter: String
    let secondParameter: String

    public init(firstParameter: String, secondParameter: String) {
        self.firstParameter = firstParameter
        self.secondParameter = secondParameter
    }

    enum CodingKeys: String, CodingKey {
        case firstParameter = "firstParameter"
        case secondParameter = "secondParameter"
    }
}
