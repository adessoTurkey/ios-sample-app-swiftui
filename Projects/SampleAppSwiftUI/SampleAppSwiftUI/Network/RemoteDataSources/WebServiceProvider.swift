//
//  WebServiceProvider.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 13.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation
import NetworkService

class WebServiceProvider {
    static let shared: WebServiceProvider = WebServiceProvider()

    let exampleService: ExampleServiceProtocol
    let allCoinService: AllCoinServiceProtocol
    let coinPriceHistoryService: CoinPriceHistoryServiceProtocol
    let coinNewsService: CoinNewsServiceProtocol

    private init() {
        exampleService = ExampleService()
        allCoinService = AllCoinService()
        coinPriceHistoryService = CoinPriceHistoryService()
        coinNewsService = CoinNewsService()
    }
}
