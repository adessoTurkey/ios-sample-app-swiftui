//
//  CoinPriceHistoryDataUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService

struct CoinPriceHistoryDataUIModel {
    let aggregated: Bool?
    let timeFrom: TimeInterval?
    let timeTo: TimeInterval?
    let data: [CoinPriceInfoUIModel]?

    init(aggregated: Bool?, timeFrom: TimeInterval?, timeTo: TimeInterval?, data: [CoinPriceInfoUIModel]?) {
        self.aggregated = aggregated
        self.timeFrom = timeFrom
        self.timeTo = timeTo
        self.data = data
    }
}

// MARK: - UIModelProtocol
extension CoinPriceHistoryDataUIModel: UIModelProtocol {
    init(from responseModel: CoinPriceHistoryData) {
        self.aggregated = responseModel.aggregated
        self.timeFrom = responseModel.timeFrom
        self.timeTo = responseModel.timeTo
        self.data = responseModel.data?.compactMap({ CoinPriceInfoUIModel(from: $0) })
    }

    init?(from responseModel: CoinPriceHistoryData?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}
