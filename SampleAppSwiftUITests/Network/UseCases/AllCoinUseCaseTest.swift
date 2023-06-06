//
//  AllCoinUseCaseTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 6.06.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class AllCoinUseCaseTest: XCTestCase {

    func test_fetchAllCoin_IfCalledAllCoinRequest() async {
        let (test, sut) = makeSUT()
        _ = try? await sut.fetchAllCoin(limit: validLimit(),
                        unitToBeConverted: validUnitToBeConverted(),
                        page: validLimit())
        XCTAssertTrue(test.didReceiveCalled)
    }

    func test_fetchAllCoin_IfAllCoinRequestThrows() async {
        let (_, sut) = makeSUT()
        do {
          try await sut.fetchAllCoin(limit: validLimit(),
                                             unitToBeConverted: throwingUnitToBeConverted,
                                             page: validLimit())
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
