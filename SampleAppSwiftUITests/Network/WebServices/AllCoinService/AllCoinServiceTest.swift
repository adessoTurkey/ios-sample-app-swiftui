//
//  AllCoinServiceTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 6.06.2023.
//

@testable import SampleAppSwiftUI

import XCTest

final class AllCoinServiceTest: XCTestCase {

    func test_allCoinRequest_IfCalledAllCoinRequest() async {
        let (test, sut) = makeSUT()
        _ = try? await sut.allCoinRequest(limit: validLimit(),
                        unitToBeConverted: validUnitToBeConverted(),
                        page: validLimit())
        XCTAssertTrue(test.didReceiveCalled)
    }

    func test_allCoinRequestn_IfAllCoinRequestThrows() async {
        let (_, sut) = makeSUT()
        do {
          try await sut.allCoinRequest(limit: validLimit(),
                                       unitToBeConverted: validUnitToBeConverted(),
                                       page: validLimit())
          XCTFail("allCoinRequest should have thrown an error")
        } catch {
        }
    }

    // MARK: BaseServiceProtocol
    func test_build_IfCalledAllCoinRequest() async {
        let (_, sut) = makeSUT()
        let test = try? await sut.build(endpoint: .allCoin())
        XCTAssertEqual(test, allCoinURLPath())
    }

    func test_authenticatedRequest_IfCalledAllCoinRequest() async {
        let (test, sut) = makeSUT()
        _ = try? await sut.authenticatedRequest(with: RequestObject(url: allCoinURLPath()),
                                                responseModel: AllCoinResponse.self)
        XCTAssertTrue(test.didReceiveCalled)
    }

    func test_authenticatedRequest_IfAllCoinRequestThrows() async {
        let (_, sut) = makeSUT()
        do {
            try await sut.authenticatedRequest(with: RequestObject(url: allCoinURLPath()),
                                                    responseModel: AllCoinResponse.self)
          XCTFail("allCoinRequest should have thrown an error")
        } catch {
        }
    }

    // MARK: Helpers
    func makeSUT() -> (AnyNetworkLoaderClass, AllCoinService) {
        let anyNetworkLoaderClass = AnyNetworkLoaderClass()
        let sut = AllCoinService(networkLoader: anyNetworkLoaderClass)
        return (anyNetworkLoaderClass, sut)
    }

    func allCoinURLPath() -> String {
        "https://min-api.cryptocompare.com/data/top/mktcapfull?limit=3&tsym=USD&page=1&api_key="
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

    class AnyNetworkLoaderClass: NetworkLoaderProtocol {
        var session: URLSessionProtocol = URLSession.shared
        var decoder: JSONDecoder = JSONDecoder()

        private(set) var didReceiveCalled = false
        let throwingRequestObject: RequestObject = .init(url: "", method: .patch)

        func request<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> T {
            didReceiveCalled = true

            if requestObject.method == throwingRequestObject.method {
                throw AdessoError.badResponse
            }
            do {
                let decodedData = try decoder.decode(responseModel, from: Data())
                return decodedData
            } catch {
                throw AdessoError.mappingFailed(data: Data())
            }
        }
    }
}
