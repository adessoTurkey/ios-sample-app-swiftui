//
//  WebSocketEndpoint.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 21.02.2023.
//

import Foundation

enum WebSocketEndpoint: TargetEndpointProtocol {
    case baseCoinApi

    var path: String {
        switch self {
            case .baseCoinApi:
                return Configuration.webSocketBaseUrl
        }
    }
}
