//
//  OSLoggerManager.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 7.09.2023.
//

import OSLog

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier

    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem ?? "", category: LoggerCategory.viewcycle.value)

    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem ?? "", category: LoggerCategory.statistics.value)

    /// All logs related to Favorite Coin Screen and subviews.
    static let favoriteCoin = Logger(subsystem: subsystem ?? "", category: LoggerCategory.favoriteCoin.value)

    /// All logs related to All Coins Screen and subviews.
    static let coins = Logger(subsystem: subsystem ?? "", category: LoggerCategory.coins.value)
}

enum LoggerCategory: String {
    case viewcycle
    case statistics
    case favoriteCoin
    case coins

    var value: String {
        self.rawValue
    }
}
