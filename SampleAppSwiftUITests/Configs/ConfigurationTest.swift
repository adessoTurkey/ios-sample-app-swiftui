//
//  ConfigurationTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 1.06.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class ConfigurationTest: XCTestCase {
    func test_isProduction() {
        #if Production
        XCTAssertTrue(Configuration.isProduction)
        #else
        XCTAssertFalse(Configuration.isAppStore)
        XCTAssertFalse(Configuration.isDevelopment)
        #endif
    }

    func test_isAppStore() {
        #if Production
        XCTAssertTrue(Configuration.isAppStore)
        #else
        XCTAssertFalse(Configuration.isProduction)
        XCTAssertFalse(Configuration.isDevelopment)
        #endif
    }

    func test_isDevelopment() {
        #if Production
        XCTAssertTrue(Configuration.isDevelopment)
        #else
        XCTAssertFalse(Configuration.isProduction)
        XCTAssertFalse(Configuration.isDevelopment)
        #endif
    }

    func test_allCoinBaseUrl_returnsValidURL() {
        XCTAssertEqual(Configuration.allCoinBaseUrl,
                       "https://min-api.cryptocompare.com/data/top/mktcapfull?limit=%d&tsym=%@&page=%d&api_key=%@")
    }

    func test_coinApiKey_returnsEmpty() {
        XCTAssertEqual(Configuration.coinApiKey, "")
    }

    func test_webSocketBaseUrl_returnsValidURL() {
        XCTAssertEqual(Configuration.webSocketBaseUrl, "wss://streamer.cryptocompare.com/v2?api_key=%@")
    }
}
