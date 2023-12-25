//
//  CoinNewsServiceEndpoint.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 20.07.2023.
//

import Foundation

enum CoinNewsServiceEndpoint: TargetEndpointProtocol {

    case coinNews(coinCode: String)

    private struct Constants {
        static let coinNewsEndpoint = "v2/news/?categories=%@&api_key=%@"
    }

    var path: String {
        switch self {
            case .coinNews(coinCode: let coinCode):
                return BaseEndpoint.base.path + String(format: Constants.coinNewsEndpoint, coinCode, Configuration.coinApiKey)
        }
    }
}
