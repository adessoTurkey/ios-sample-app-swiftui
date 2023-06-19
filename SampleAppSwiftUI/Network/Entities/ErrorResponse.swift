//
//  ErrorResponse.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 10.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

class ErrorResponse: Codable {
    var code: Int?
    var message: String?
    var messages: [String: String]?
}
