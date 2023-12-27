//
//  CoinPriceHistoryUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService

struct CoinPriceHistoryUIModel {
    let data: CoinPriceHistoryDataUIModel?

    init(data: CoinPriceHistoryDataUIModel?) {
        self.data = data
    }
}

// MARK: - UIModelProtocol
extension CoinPriceHistoryUIModel: UIModelProtocol {
    init(from responseModel: CoinPriceHistoryResponse) {
        self.data = CoinPriceHistoryDataUIModel(from: responseModel.data)
    }

    init?(from responseModel: CoinPriceHistoryResponse?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}
