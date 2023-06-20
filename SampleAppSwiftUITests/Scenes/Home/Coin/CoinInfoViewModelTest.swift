//
//  CoinInfoViewModelTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 18.05.2023.
//

@testable import SampleAppSwiftUI
import XCTest

//final class CoinInfoViewModelTest: XCTestCase {
//
//    let coinInfoViewModel = CoinInfoViewModel()
//
//    func test_createPriceString() {
//        let rawUsd = RawUsd(price: 29467.560,
//                            changeAmount: 28.015,
//                            changePercentage: 29.74)
//        let coinInfo = coinInfoViewModel.createPriceString(rawData: rawUsd)
//        XCTAssertEqual(coinInfo, "$29,467.56")
//    }
//
//    func test_getURL() {
//        let url = coinInfoViewModel.getURL(from: "BTC")
//        XCTAssertEqual(url, URL(string: "https://assets.coincap.io/assets/icons/btc@2x.png"))
//    }
//
//    func test_createChangeText() {
//        let rawUsd = RawUsd(price: 29467.560,
//                            changeAmount: 28.015,
//                            changePercentage: 29.74)
//        let changeText = coinInfoViewModel.createChangeText(rawData: rawUsd)
//        XCTAssertEqual(changeText, "29.74% ($28.015)" )
//    }
//}
