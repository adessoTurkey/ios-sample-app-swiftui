//
//  AllCoinRemoteDataSourceTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 5.06.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class AllCoinRemoteDataSourceTest: XCTestCase {

    let validLimit = 3
    let validPage = 5
    let validUnitToBeConverted = "USD"
    let throwingUnitToBeConverted: String = "Create Throw"

    func test_getAllCoin_WasCalledAllCoinRequest() async {
        // GIVEN
        let (test, sut) = makeSUT()
        // WHEN
        _ = try? await sut.getAllCoin(limit: validLimit,
                                      unitToBeConverted: validUnitToBeConverted,
                                      page: validPage)
        // THEN
        XCTAssertTrue(test.didReceiveCalled)
    }

    func test_getAllCoin_AllCoinRequestThrows() async {
        // GIVEN
        let (_, sut) = makeSUT()
        // WHEN
        do {
          try await sut.getAllCoin(limit: validLimit,
                                   unitToBeConverted: throwingUnitToBeConverted,
                                   page: validPage)
        // THEN
          XCTFail("getAllCoin should have thrown an error")
        } catch {
        }
    }

    // MARK: Helpers
    func makeSUT() -> (AnyAllCoinServiceProtocol, AllCoinRemoteDataSource) {
        let anyAllCoinServiceProtocol = AnyAllCoinServiceProtocol()
        let sut = AllCoinRemoteDataSource(allCoinService: anyAllCoinServiceProtocol)
        return (anyAllCoinServiceProtocol, sut)
    }

    class AnyAllCoinServiceProtocol: AllCoinServiceProtocol {
        private(set) var didReceiveCalled = false
        let throwingUnitToBeConverted: String = "Create Throw"

        func allCoinRequest(limit: Int, unitToBeConverted: String, page: Int) async throws -> AllCoinResponse {
            didReceiveCalled = true
            if unitToBeConverted == throwingUnitToBeConverted {
                throw AdessoError.badResponse
            }
            return AllCoinResponse(data: nil)
        }
    }
}
