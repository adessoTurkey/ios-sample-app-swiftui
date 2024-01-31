//
//  RawUsdUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService
import SwiftUI

struct RawUsdUIModel: Codable, Hashable {
    var price: Double?
    var changeAmount: Double?
    var changePercentage: Double?

    init(price: Double? = nil, changeAmount: Double? = nil, changePercentage: Double? = nil) {
        self.price = price
        self.changeAmount = changeAmount
        self.changePercentage = changePercentage
    }

    static func == (lhs: RawUsdUIModel, rhs: RawUsdUIModel) -> Bool {
        lhs.price == rhs.price &&
        lhs.changeAmount == rhs.changeAmount &&
        lhs.changePercentage == rhs.changePercentage
    }
}

// MARK: - UIModelProtocol
extension RawUsdUIModel: UIModelProtocol {
    init(from responseModel: RawUsd) {
        self.price = responseModel.price
        self.changeAmount = responseModel.changeAmount
        self.changePercentage = responseModel.changePercentage
    }

    init?(from responseModel: RawUsd?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}

// MARK: - Utilities
extension RawUsdUIModel {

    func createForegroundColor() -> Color {
        let percentage = self.changePercentage ?? 0
        switch percentage {
            case let change where change > 0:
                return .green
            case let change where change < 0:
                return .red
            default:
                return .gray
        }
    }

    func createPriceString() -> String {
        self.price?.formatted(.currency(code: "USD").precision(.fractionLength(Range.currency))) ?? ""
    }

    func createChangeText() -> String {
        "\(createPercentageText()) (\(createAmountText()))"
    }

    func createPercentageText() -> String {
        ((self.changePercentage ?? 0) / 100)
            .formatted(.percent.precision(.fractionLength(Range.currency)))
    }

    func createAmountText() -> String {
        self.changeAmount?
            .formatted(.currency(code: "USD")
                .precision(.fractionLength(Range.currency))) ?? ""
    }
}
