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
        // GIVEN
        let validLimit = 3
        let validPage = 5
        let validUnitToBeConverted = "USD"
        let allCoinFullURL = "https://min-api.cryptocompare.com/data/top/mktcapfull?limit=\(validLimit)&tsym=\(validUnitToBeConverted)&page=\(validPage)&api_key="
        // WHEN
        let testEndpoint = AllCoinServiceEndpoint.allCoin(limit: validLimit,
                                                      unitToBeConverted: validUnitToBeConverted,
                                                      page: validPage)
        let testPath = testEndpoint.path
        // THEN
        XCTAssertEqual(testPath, allCoinFullURL)
    }
}
