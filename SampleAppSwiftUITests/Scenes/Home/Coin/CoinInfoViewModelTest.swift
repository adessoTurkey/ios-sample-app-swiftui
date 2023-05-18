//
//  CoinInfoViewModelTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 18.05.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class CoinInfoViewModelTest: XCTestCase {

    func testCreatePriceString() {
        let coinInfoViewModel = CoinInfoViewModel()
        let rawUsd = RawUsd(price: 29467.560,
                            changeAmount: 28.015,
                            changePercentage: 29.74)
        let coinInfo = coinInfoViewModel.createPriceString(rawData: rawUsd)
        XCTAssertEqual(coinInfo, "$29,467.56")
    }
}
