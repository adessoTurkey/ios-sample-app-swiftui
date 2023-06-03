//
//  WebSocketServiceTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 29.05.2023.
//

@testable import SampleAppSwiftUI
import XCTest
import Combine

final class WebSocketServiceTest: XCTestCase {
//
//    func test_connect_returnsNil_ifEndPointIsInvalid() {
//        let sut = makeSUT()
////        let endPoint = WebSocketEndpoint.
//        let endPoint = TestTargetEndpoint(path: invalidUrl())
//        XCTAssertNil(sut.connect(endPoint: endPoint), "Expected nil, while invalid Url, got sut \(String(describing: sut.stream))")
//    }
//
//    func test_connect_returnsItself_ifEndPointIsValid() {
//        let sut = makeSUT()
//        let endPoint = TestTargetEndpoint(path: anyWssUrl())
//        XCTAssertNotNil(sut.connect(endPoint: endPoint), "Expected Itself, while valid Url, got sut \(String(describing: sut.stream))")
//    }

    func test_receive_receiveNotCalled_IfCalledWithoutConnect() {
        let sut = makeSUT()
        let subscriber = SubscriberSpy()
        sut.receive(subscriber: subscriber)
        XCTAssertFalse(subscriber.didReceiveCalled)
    }

//    func test_receive_receiveCalled_IfCalledWithConnect() {
//        let sut = makeSUT()
//        let subscriber = SubscriberSpy()
//        sut.connect(endPoint: TestTargetEndpoint(path: anyWssUrl()))?
//            .receive(subscriber: subscriber)
//        XCTAssertTrue(subscriber.didReceiveCalled)
//    }
//
//    func test_disconnect_streamIsNil() {
//        let sut = makeSUT()
//        let endPoint = TestTargetEndpoint(path: anyWssUrl())
//        XCTAssertNotNil(sut.connect(endPoint: endPoint),
//                        "Expected Itself, while valid Url, got sut \(String(describing: sut.stream))")
//        sut.disconnect()
//        XCTAssertNil(sut.stream, "Expected nil, after disconnect method, got sut \(String(describing: sut.stream))")
//    }

    // MARK: Helpers
    func invalidUrl() -> String {
        "Invalid Letter: Ü"
    }

    func anyWssUrl() -> String {
        "wss://test"
    }

    func makeSUT() -> WebSocketService {
        WebSocketService()
    }

    struct TestTargetEndpoint: TargetEndpointProtocol {
        var path: String
    }

    class SubscriberSpy: Subscriber {
        typealias Input = URLSessionWebSocketTask.Message
        typealias Failure = Error

        private(set) var didReceiveCalled = false

        func receive(_ input: URLSessionWebSocketTask.Message) -> Subscribers.Demand {

                didReceiveCalled = true
            return Subscribers.Demand.none
        }
        func receive(subscription: Subscription) {
            didReceiveCalled = true
        }
        func receive(completion: Subscribers.Completion<Failure>) {
            didReceiveCalled = true
        }
    }
}
