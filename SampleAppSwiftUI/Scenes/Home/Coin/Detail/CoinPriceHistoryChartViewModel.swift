//
//  CoinPriceHistoryChartViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 5.06.2023.
//

import Foundation
import SwiftUI
import Charts

class CoinPriceHistoryChartViewModel: ObservableObject {
    var selectedRange: CoinChartHistoryRange
    var dataModel: CoinPriceHistoryChartDataModel
    @Binding var selectedXDateText: String
    /// Holds the selected x value of chart when user is dragging on it
    @Published var selectedX: (any Plottable)?

    init(selectedRange: CoinChartHistoryRange, dataModel: CoinPriceHistoryChartDataModel, selectedXDateText: Binding<String>) {
        self.selectedRange = selectedRange
        self.dataModel = dataModel
        self._selectedXDateText = selectedXDateText
        self.selectedX = nil
    }

    private let selectedValueDateFormatter = {
        let dfm = DateFormatter()
        dfm.dateStyle = .medium
        return dfm
    }()

    var chartYScaleDomain: ClosedRange<Float> {
        let averages = dataModel.prices.map { $0.average }
        let min = (averages.min() ?? 0)
        let max = (averages.max() ?? 1)
        return min...max
    }

    var chartXScaleDomain: ClosedRange<Date> {
        guard let firstDate = dataModel.prices.first?.date, let lastDate = dataModel.prices.last?.date else { return Date()...Date().advanced(by: 3600) }

        return firstDate...lastDate
    }

    var selectedXRuleMark: (value: Date, text: String)? {
        guard let selectedX = selectedX as? Date else { return nil }

        let index = DateBins(thresholds: dataModel.prices.map { $0.date }).index(for: selectedX)
        return (selectedX, format(price: Double(dataModel.prices[index].average)))
    }

    var foregroundMarkColor: Color {
        (selectedX != nil) ? .cyan : dataModel.lineColor
    }

    var calculatedSelectedXDateText: String {
        guard let selectedX = selectedX as? Date else { return "" }

        if selectedRange == .oneDay || selectedRange == .oneWeek {
            selectedValueDateFormatter.timeStyle = .short
        } else {
            selectedValueDateFormatter.timeStyle = .none
        }

        let index = DateBins(thresholds: dataModel.prices.map { $0.date }).index(for: selectedX)
        let item = dataModel.prices[index]
        return selectedValueDateFormatter.string(from: item.date)
    }

    func onChangeDrag(value: DragGesture.Value, chartProxy: ChartProxy, geometryProxy: GeometryProxy) {
        if let plotFrame = chartProxy.plotFrame {
            let xCurrent = value.location.x - geometryProxy[plotFrame].origin.x

            if let selectedDate: Date = chartProxy.value(atX: xCurrent),
               let startDate = dataModel.prices.first?.date,
               let lastDate = dataModel.prices.last?.date,
               selectedDate >= startDate && selectedDate <= lastDate {
                selectedX = selectedDate
                selectedXDateText = calculatedSelectedXDateText
            }
        }
    }

    func onEndDrag() {
        selectedX = nil
        selectedXDateText = ""
    }

    func format(price: Double) -> String {
        price.formatted(.number.precision(.fractionLength(2...3)))
    }
}
