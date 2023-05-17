//
//  WebSocketEndpoint.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 21.02.2023.
//

import Foundation

enum WebSocketEndpoint: TargetEndpointProtocol {
    case baseCoinApi

    private struct Constants {
        static let webSocketEndpoint = Configuration.webSocketBaseUrl
        static let apiKey = Configuration.coinApiKey
    }

    var path: String {
        switch self {
            case .baseCoinApi:
            return String(format: Constants.webSocketEndpoint, Constants.apiKey)
        }
    }
}
