//
//  CoinPriceInfoUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService

struct CoinPriceInfoUIModel {
    let time: TimeInterval?
    let high: Float?
    let low: Float?
    let open: Float?
    let volumeFrom: Float?
    let volumeTo: Float?
    let close: Float?

    init(
        time: TimeInterval?,
        high: Float?,
        low: Float?,
        open: Float?,
        volumeFrom: Float?,
        volumeTo: Float?,
        close: Float?
    ) {
        self.time = time
        self.high = high
        self.low = low
        self.open = open
        self.volumeFrom = volumeFrom
        self.volumeTo = volumeTo
        self.close = close
    }
}

// MARK: - UIModelProtocol
extension CoinPriceInfoUIModel: UIModelProtocol {
    init(from responseModel: CoinPriceInfo) {
        self.time = responseModel.time
        self.high = responseModel.high
        self.low = responseModel.low
        self.open = responseModel.open
        self.volumeFrom = responseModel.volumeFrom
        self.volumeTo = responseModel.volumeTo
        self.close = responseModel.close
    }

    init?(from responseModel: CoinPriceInfo?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}
