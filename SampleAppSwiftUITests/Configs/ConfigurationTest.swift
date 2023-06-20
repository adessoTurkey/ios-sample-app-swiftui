//
//  ConfigurationTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 1.06.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class ConfigurationTest: XCTestCase {

    let emptyString: String = ""
    let validString: String = "base_url"

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
        let validAllCoinBaseUrl = "https://min-api.cryptocompare.com/data/"
        XCTAssertEqual(Configuration.baseURL, validAllCoinBaseUrl)
    }

    func test_coinApiKey_returnsEmpty() {
        XCTAssertEqual(Configuration.coinApiKey, emptyString)
    }

    func test_webSocketBaseUrl_returnsValidURL() {
        let validWebSocketBaseUrl: String = "wss://streamer.cryptocompare.com/v2?api_key=%@"
        XCTAssertEqual(Configuration.webSocketBaseUrl, validWebSocketBaseUrl)
    }

    func test_value_throwsMissingKeyErrorWhileInvalidString() {
        XCTAssertThrowsError(try Configuration.value(for: emptyString) as String)
    }

    func test_value_returnsSubStringTypeWhileValidStringAsSubstring() {
        XCTAssertTrue(type(of: (try Configuration.value(for: validString) as Substring)) == Substring.self)
    }

    func test_value_throwsInvalidValueErrorWhileWhileValidStringAsInt() {
        XCTAssertThrowsError(try Configuration.value(for: validString) as Int)
    }
}
