//
//  BaseEndpoint.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 11.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

enum BaseEndpoint: TargetEndpointProtocol {
    case base
    case allCoin

    var path: String {
        switch self {
            case .base:
                return Configuration.baseURL
            case .allCoin:
                return "https://min-api.cryptocompare.com/data/top/mktcapfull"
        }
    }
}
