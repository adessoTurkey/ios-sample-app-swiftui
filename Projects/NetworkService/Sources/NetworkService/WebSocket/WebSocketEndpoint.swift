//
//  WebSocketEndpoint.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 21.02.2023.
//

import Foundation

public enum WebSocketEndpoint: TargetEndpointProtocol {
    case baseCoinApi

    private struct Constants {
        static let webSocketEndpoint = Configuration.webSocketBaseUrl
        //static let apiKey = Configuration.coinApiKey
    }

    public var path: String {
        switch self {
            case .baseCoinApi:
            return Constants.webSocketEndpoint
        }
    }
}
