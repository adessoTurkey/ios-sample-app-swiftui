//
//  WebSocketServiceTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 29.05.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class WebSocketServiceTest: XCTestCase {

    func test_connect_returnsNilIfEndPointIsInvalid() {
        let sut = makeSUT()
        let endPoint = TestTargetEndpoint(path: invalidUrl())
        XCTAssertNil(sut.connect(endPoint: endPoint), "Expected nil, while invalid Url, got sut \(String(describing: sut.stream))")
    }

    // MARK: Helpers
    func invalidUrl() -> String {
        "Invalid Letter: Ü"
    }

    func makeSUT() -> WebSocketService {
        WebSocketService.shared
    }

    struct TestTargetEndpoint: TargetEndpointProtocol {
        var path: String
    }
}
