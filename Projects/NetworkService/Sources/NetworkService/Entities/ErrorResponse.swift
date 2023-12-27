//
//  ErrorResponse.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 10.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

public class ErrorResponse: Decodable {
    public var code: Int?
    public var message: String?
    public var messages: [String: String]?
}
