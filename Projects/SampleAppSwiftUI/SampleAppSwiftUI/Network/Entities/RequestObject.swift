//
//  RequestObject.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 10.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

struct RequestObject {
    var url: String
    let method: HTTPMethod
    var data: Encodable?
    var headers: [String: String]?

    init(url: String,
         method: HTTPMethod = .get,
         data: Encodable? = nil,
         headers: [String: String] = [:]) {
        self.url = url
        self.method = method
        self.data = data
        self.headers = headers
    }
}

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
