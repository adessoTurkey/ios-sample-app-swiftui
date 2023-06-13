//
//  BaseServiceProtocolTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 13.06.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class BaseServiceProtocolTest: XCTestCase {
    let allCoinURLPath = "https://min-api.cryptocompare.com/data/top/mktcapfull?limit=3&tsym=USD&page=1&api_key="
    let validLimit = 3
    let validUnitToBeConverted = "USD"

    func test_build_ReturnsAllCoinURLPath() async {
        // GIVEN
        let (_, sut) = makeSUT()
        // WHEN
        let test = try? await sut.build(endpoint: .allCoin())
        // THEN
        XCTAssertEqual(test, allCoinURLPath)
    }

    func test_authenticatedRequest_WasCalledRequest() async {
        // GIVEN
        let (test, sut) = makeSUT()
        // WHEN
        _ = try? await sut.authenticatedRequest(with: RequestObject(url: allCoinURLPath),
                                                responseModel: AllCoinResponse.self)
        // THEN
        XCTAssertTrue(test.didReceiveCalled)
    }

    func test_authenticatedRequest_RequestThrows() async {
        // GIVEN
        let (_, sut) = makeSUT()
        // WHEN
        do {
            try await sut.authenticatedRequest(with: RequestObject(url: allCoinURLPath),
                                               responseModel: AllCoinResponse.self)
        // THEN
          XCTFail("allCoinRequest should have thrown an error")
        } catch {
        }
    }

    // MARK: Helpers
    func makeSUT() -> (AnyNetworkLoaderClass, AnyBaseServiceProtocol) {
        let anyNetworkLoaderClass = AnyNetworkLoaderClass()
        let sut = AnyBaseServiceProtocol(networkLoader: anyNetworkLoaderClass)
        return (anyNetworkLoaderClass, sut)
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

    // Helpers
    class AnyBaseServiceProtocol: BaseServiceProtocol {
        var networkLoader: SampleAppSwiftUI.NetworkLoaderProtocol
        typealias Endpoint = AllCoinServiceEndpoint

        internal init(networkLoader: NetworkLoaderProtocol) {
            self.networkLoader = networkLoader
        }
    }
}
