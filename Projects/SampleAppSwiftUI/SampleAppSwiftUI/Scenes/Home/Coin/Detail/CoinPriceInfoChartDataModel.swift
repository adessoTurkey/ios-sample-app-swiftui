//
//  CoinPriceInfoChartDataModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 30.05.2023.
//

import SwiftUI

struct CoinPriceHistoryChartDataModel {
    let aggregated: Bool?
    let timeFrom: TimeInterval?
    let timeTo: TimeInterval?
    let prices: [CoinPriceInfoChartDataModel]
    let lineColor: Color

    init(from coinPriceHistoryData: CoinPriceHistoryDataUIModel) {
        self.aggregated = coinPriceHistoryData.aggregated
        self.timeFrom = coinPriceHistoryData.timeFrom
        self.timeTo = coinPriceHistoryData.timeTo
        self.prices = coinPriceHistoryData.data?.compactMap({ CoinPriceInfoChartDataModel(from: $0) }) ?? []

        let lastTwoElements = self.prices.suffix(2)
        if let first = lastTwoElements.first, let last = lastTwoElements.last {
            self.lineColor = last.average >= first.average ? .green : .red
        } else {
            self.lineColor = .blue
        }
    }
}

struct CoinPriceInfoChartDataModel: Identifiable, Hashable {
    let id = UUID().uuidString
    let date: Date
    let average: Float
    let timeStamp: TimeInterval
    let high: Float
    let low: Float
    let open: Float?
    let volumeFrom: Float?
    let volumeTo: Float?
    let close: Float?

    init?(from coinPriceInfo: CoinPriceInfoUIModel) {
        guard let time = coinPriceInfo.time, let high = coinPriceInfo.high, let low = coinPriceInfo.low else {
            return nil
        }

        self.date = Date(timeIntervalSince1970: time)
        self.average = (high + low) / 2.0
        self.timeStamp = time
        self.high = high
        self.low = low
        self.open = coinPriceInfo.open
        self.volumeFrom = coinPriceInfo.volumeFrom
        self.volumeTo = coinPriceInfo.volumeTo
        self.close = coinPriceInfo.close
    }

    static func == (lhs: CoinPriceInfoChartDataModel, rhs: CoinPriceInfoChartDataModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.timeStamp == rhs.timeStamp
    }
}

// MARK: - DEMO
extension CoinPriceHistoryChartDataModel {
    // swiftlint:disable line_length
    static let demo = CoinPriceHistoryChartDataModel(
        from: CoinPriceHistoryDataUIModel(
            aggregated: false,
            timeFrom: 1684972800,
            timeTo: 1685404800,
            data: [
                CoinPriceInfoUIModel(time: 1684972800, high: 3.592, low: 3.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685059200, high: 4.592, low: 3.544, open: 4.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685145600, high: 5.592, low: 2.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685613085, high: 6.592, low: 3.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685633085, high: 7.592, low: 3.544, open: 4.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685653085, high: 8.592, low: 2.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685673085, high: 9.592, low: 3.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685693085, high: 17.592, low: 0.544, open: 4.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685713085, high: 2.592, low: 2.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685733085, high: 6.592, low: 3.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685753085, high: 3.592, low: 3.544, open: 4.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685773085, high: 2.592, low: 2.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685793085, high: 7.592, low: 3.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685813085, high: 11.592, low: 3.544, open: 4.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfoUIModel(time: 1685833085, high: 15.592, low: 2.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563)
            ]
        )
    )
    // swiftlint:enable line_length
}
