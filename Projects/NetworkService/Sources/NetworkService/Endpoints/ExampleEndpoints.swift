//
//  ExampleEndpoints.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 16.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

enum ExampleEndpoints: TargetEndpointProtocol {
    case example(firstParameter: String, secondParameter: String)

    private struct Constants {
        static let exampleEndpoint = "exampleEndpoint/%@/%@"
    }

    var path: String {
        switch self {
            case .example(let firstParameter, let secondParameter):
                return BaseEndpoints.base.path + String(format: Constants.exampleEndpoint, firstParameter, secondParameter)
        }
    }
}
