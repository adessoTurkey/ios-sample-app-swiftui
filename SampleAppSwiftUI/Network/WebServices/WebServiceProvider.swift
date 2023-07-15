//
//  WebServiceProvider.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 13.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

class WebServiceProvider {
    static let shared: WebServiceProvider = WebServiceProvider()

    let exampleService: ExampleServiceProtocol
    let allCoinService: AllCoinServiceProtocol
    let selectedCoinsService: SelectedCoinsServiceProtocol
    let coinPriceHistoryService: CoinPriceHistoryServiceProtocol

    private init() {
        exampleService = ExampleService()
        allCoinService = AllCoinService()
        selectedCoinsService = SelectedCoinsService()
        coinPriceHistoryService = CoinPriceHistoryService()
    }
}
