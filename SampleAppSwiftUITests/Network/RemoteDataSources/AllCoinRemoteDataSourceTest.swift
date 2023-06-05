//
//  AllCoinRemoteDataSourceTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 5.06.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class AllCoinRemoteDataSourceTest: XCTestCase {

    func test_getAllCoin_IfCalledAllCoinRequest() async {
        let (test, sut) = makeSUT()
        _ = try? await sut.getAllCoin(limit: validLimit(),
                        unitToBeConverted: validUnitToBeConverted(),
                        page: validLimit())
        XCTAssertTrue(test.didReceiveCalled)
    }

    func test_getAllCoin_IfAllCoinRequestThrows() async {
        let (_, sut) = makeSUT()
        do {
          try await sut.getAllCoin(limit: validLimit(),
                                             unitToBeConverted: throwingUnitToBeConverted,
                                             page: validLimit())
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

    let throwingUnitToBeConverted: String = "Create Throw"

    func validLimit() -> Int {
        3
    }

    func validUnitToBeConverted() -> String {
        "USD"
    }

    func validPage() -> Int {
        5
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
