//
//  CoinChartHistoryRange.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 23.05.2023.
//

import Foundation

enum CoinChartHistoryRange: String, CaseIterable, Identifiable {
    case oneDay = "1D"
    case oneWeek = "1W"
    case oneMonth = "1M"
    case threeMonth = "3M"
    case sixMonth = "6M"
    case oneYear = "1Y"
    case all = "ALL"

    var id: Self { self }
}

extension CoinChartHistoryRange {
    var limitAndAggregateValue: (limit: Int, aggregate: Int) {
        switch self {
            case .oneDay:
                return (limit: 24, aggregate: 1)
            case .oneWeek:
                return (limit: 7, aggregate: 1)
            case .oneMonth:
                return (limit: 30, aggregate: 1)
            case .threeMonth:
                return (limit: 90, aggregate: 1)
            case .sixMonth:
                return (limit: 180, aggregate: 1)
            case .oneYear:
                return (limit: 365, aggregate: 1)
            case .all:
                return (limit: 2000, aggregate: 1)
        }
    }
}

extension CoinChartHistoryRange {
    struct XAxisFormatter {
        var strideCalendarComponent: Calendar.Component
        var strideCount: Int
        var valueLabelDateFormatStyle: Date.FormatStyle
    }

    var xAxisFormatter: XAxisFormatter {
        switch self {
            case .oneDay:
            return XAxisFormatter(strideCalendarComponent: .hour, strideCount: 4, valueLabelDateFormatStyle: .dateTime.hour(.defaultDigits(amPM: .abbreviated)))
            case .oneWeek:
                return XAxisFormatter(strideCalendarComponent: .day, strideCount: 1, valueLabelDateFormatStyle: .dateTime.day(.twoDigits))
            case .oneMonth:
                return XAxisFormatter(strideCalendarComponent: .day, strideCount: 7, valueLabelDateFormatStyle: .dateTime.day(.twoDigits))
            case .threeMonth, .sixMonth:
                return XAxisFormatter(strideCalendarComponent: .month, strideCount: 1, valueLabelDateFormatStyle: .dateTime.month(.abbreviated))
            case .oneYear:
                return XAxisFormatter(strideCalendarComponent: .month, strideCount: 3, valueLabelDateFormatStyle: .dateTime.month(.abbreviated))
            case .all:
                return XAxisFormatter(strideCalendarComponent: .year, strideCount: 1, valueLabelDateFormatStyle: .dateTime.year())
        }
    }
}
