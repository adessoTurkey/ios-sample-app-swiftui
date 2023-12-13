//
//  RawUsd+Extension.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 31.05.2023.
//

import Foundation

extension RawUsd {
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
