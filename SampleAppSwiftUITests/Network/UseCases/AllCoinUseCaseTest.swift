//
//  AllCoinUseCaseTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 6.06.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class AllCoinUseCaseTest: XCTestCase {

    let validLimit = 3
    let validPage = 5
    let validUnitToBeConverted = "USD"
    let throwingUnitToBeConverted: String = "Create Throw"

    func test_fetchAllCoin_WasCalledGetAllCoin() async {
        // GIVEN
        let (test, sut) = makeSUT()
        // WHEN
        _ = try? await sut.fetchAllCoin(limit: validLimit,
                                        unitToBeConverted: validUnitToBeConverted,
                                        page: validPage)
        // THEN
        XCTAssertTrue(test.didReceiveCalled)
    }

    func test_fetchAllCoin_GetAllCoinThrows() async {
        // GIVEN
        let throwingUnitToBeConverted: String = "Create Throw"
        let (_, sut) = makeSUT()
        // WHEN
        do {
          try await sut.fetchAllCoin(limit: validLimit,
                                     unitToBeConverted: throwingUnitToBeConverted,
                                     page: validPage)
          // THEN
          XCTFail("getAllCoin should have thrown an error")
        } catch {
        }
    }

    // MARK: Helpers
    func makeSUT() -> (AnyAllCoinRepositoryClass, AllCoinUseCase) {
        let anyAllCoinRepository = AnyAllCoinRepositoryClass()
        let sut = AllCoinUseCase(allCoinRepository: anyAllCoinRepository)
        return (anyAllCoinRepository, sut)
    }

    class AnyAllCoinRepositoryClass: AllCoinRepositoryProtocol {
        private(set) var didReceiveCalled = false
        let throwingUnitToBeConverted: String = "Create Throw"

        func getAllCoin(limit: Int, unitToBeConverted: String, page: Int) async throws -> AllCoinResponse {
            didReceiveCalled = true
            if unitToBeConverted == throwingUnitToBeConverted {
                throw AdessoError.badResponse
            }
            return AllCoinResponse(data: nil)
        }
    }
}
