//
//  SelectedCoinsServiceEndpoint.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 15.07.2023.
//

import Foundation

enum SelectedCoinsServiceEndpoint: TargetEndpointProtocol {
    case selectedCoins(_ selectedCoins: [CoinCode], unitToBeConverted: String = "USD")

    private struct Constants {
        static let allCoinEndpoint = "pricemultifull?fsyms=%@&tsyms=%@"
    }

    var path: String {
        switch self {
            case .selectedCoins(let selectedCoins, let toConvert):
            let selectedCoinsString = selectedCoins.joined(separator: ",")
            return BaseEndpoint.base.path + String(format: Constants.allCoinEndpoint,
                                                   selectedCoinsString, toConvert, Configuration.coinApiKey)
        }
    }
}
