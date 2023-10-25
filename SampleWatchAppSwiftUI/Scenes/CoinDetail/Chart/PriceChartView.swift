//
//  PriceChartView.swift
//  SampleWatchAppSwiftUI
//
//  Created by Yildirim, Alper on 17.10.2023.
//

import SwiftUI
import Charts

struct PriceChartView: View {
    @StateObject private var viewModel = CoinPriceHistoryChartViewModel()
    let coin: CoinData

    var body: some View {
        VStack {
            Text(viewModel.pageState == .finished ? " " : viewModel.pageState.stateUIString)
                .animation(.easeIn, value: viewModel.pageState)
                .font(.footnote)
                .foregroundColor(.gray.opacity(0.6))

            chart
                .chartXScale(domain: viewModel.chartXScaleDomain)
                .chartYScale(domain: viewModel.chartYScaleDomain)
                .task {
                    await viewModel.fetchCoinPriceHistory(for: coin)
                }
        }
    }

    private var chart: some View {
        Chart(viewModel.coinPrices) {
            AreaMark(
                x: .value("Date", $0.date),
                yStart: .value("Low", viewModel.chartYScaleDomain.lowerBound),
                yEnd: .value("Average", $0.average)
            )
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [.black, .clear]),
                    startPoint: .top,
                    endPoint: .center
                )
            )
            .opacity(0.5)

            LineMark(
                x: .value("Date", $0.date),
                y: .value("Average", $0.average)
            )
            .interpolationMethod(.monotone)
            .foregroundStyle(viewModel.dataModel?.lineColor ?? .white)
        }
    }

    func formatDate(_ date: Date) -> String {
        date.formatted(date: .omitted, time: .shortened)
    }
}

struct PriceChartView_Previews: PreviewProvider {
    static var previews: some View {
        PriceChartView(coin: .demo)
    }
}

struct CoinPriceHistoryChartDataModel {
    let aggregated: Bool?
    let timeFrom: TimeInterval?
    let timeTo: TimeInterval?
    let prices: [CoinPriceInfoChartDataModel]
    let lineColor: Color

    init(from coinPriceHistoryData: CoinPriceHistoryData) {
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

    static let demo = CoinPriceHistoryChartDataModel(
        from: CoinPriceHistoryData(
            aggregated: false,
            timeFrom: 1684972800,
            timeTo: 1685404800,
            data: [
                CoinPriceInfo(time: 1684972800, high: 3.592, low: 3.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685059200, high: -3.592, low: 3.544, open: 4.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685145600, high: 5.592, low: 2.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685613085, high: 6.592, low: 3.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685633085, high: 7.592, low: 3.544, open: 4.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685653085, high: 8.592, low: 2.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685673085, high: 9.592, low: 3.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685693085, high: 7.592, low: 0.544, open: 4.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685713085, high: 2.592, low: 2.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685733085, high: 6.592, low: 3.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685753085, high: 3.592, low: 3.544, open: 4.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685773085, high: 2.592, low: 2.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685793085, high: 7.592, low: 3.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685813085, high: 11.592, low: 3.544, open: 4.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563),
                CoinPriceInfo(time: 1685833085, high: 15.592, low: 2.544, open: 3.562, volumeFrom: 15886.3, volumeTo: 56872.31, close: 3.563)
            ]
        )
    )
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

    init?(from coinPriceInfo: CoinPriceInfo) {
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
