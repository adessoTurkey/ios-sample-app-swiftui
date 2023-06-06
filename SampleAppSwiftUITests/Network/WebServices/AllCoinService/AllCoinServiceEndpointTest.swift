//
//  AllCoinServiceEndpointTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 6.06.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class AllCoinServiceEndpointTest: XCTestCase {

    func test_Constants() async {
        XCTAssertEqual(AllCoinServiceEndpoint.allCoin(limit: validLimit(),
                                                      unitToBeConverted: validUnitToBeConverted(),
                                                      page: validPage())
                                              .path,
                       allCoinFullURL())
    }

    // MARK: Helpers
    func allCoinFullURL() -> String {
        "https://min-api.cryptocompare.com/data/top/mktcapfull?limit=\(validLimit())&tsym=\(validUnitToBeConverted())&page=\(validPage())&api_key="
    }

    func validLimit() -> Int {
        3
    }

    func validUnitToBeConverted() -> String {
        "USD"
    }

    func validPage() -> Int {
        5
    }
}
