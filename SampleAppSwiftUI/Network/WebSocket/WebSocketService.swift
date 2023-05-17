//
//  WebSocketService.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 21.02.2023.
//

import Foundation
import Combine

protocol WebSocketServiceProtocol: AnyObject, Publisher where Self.Output == URLSessionWebSocketTask.Message, Self.Failure == Error {
    func connect(endPoint: WebSocketEndpoint) -> (any WebSocketServiceProtocol)?
    func sendMessage(_ message: FavoritesCoinRequest)
    func disconnect()
    func connectionHandler(connected: @escaping (any WebSocketServiceProtocol) -> Void,
                           disconnected: @escaping (URLSessionWebSocketTask.CloseCode) -> Void) -> AnyPublisher<URLSessionWebSocketTask.Message, Error>
    func setPing(time: TimeInterval)
}

final class WebSocketService: NSObject, WebSocketServiceProtocol {

    typealias Output = URLSessionWebSocketTask.Message
    typealias Input =  URLSessionWebSocketTask.Message
    typealias Failure = Error

    static let shared = WebSocketService()

    private var stream: WebSocketStream?
    private var disconnectionHandler: (URLSessionWebSocketTask.CloseCode) -> Void = { _ in }
    private var connectionHandler: (any WebSocketServiceProtocol) -> Void = { _ in }

    private override init() {}

    func connect(endPoint: WebSocketEndpoint) -> (any WebSocketServiceProtocol)? {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        guard let provider = WebSocketProvider(endPoint: endPoint, session: session) else {
            return nil
        }
        stream = provider.socket
        return self
    }

    func receive<S: Subscriber>(subscriber: S) where WebSocketService.Failure == S.Failure, WebSocketService.Output == S.Input {
        guard let stream else { return }
        let subscription = WebSocketSubscription(socket: stream, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }

    func connectionHandler(connected: @escaping (any WebSocketServiceProtocol) -> Void,
                           disconnected: @escaping (URLSessionWebSocketTask.CloseCode) -> Void) -> AnyPublisher<URLSessionWebSocketTask.Message, Error> {
        disconnectionHandler = disconnected
        connectionHandler = connected
        return self.eraseToAnyPublisher()
    }

    func sendMessage(_ message: FavoritesCoinRequest) {
        guard let messageString = message.toJSONString() else { return }
        stream?.send(string: messageString)
    }

    func disconnect() {
        stream?.cancel(closeCode: .goingAway)
        stream = nil
    }

    func setPing(time: TimeInterval = 10) {
        stream?.sentPingRegularly = true
        stream?.pingTimeInterval = time
    }
}

extension WebSocketService: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        connectionHandler(self)
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        disconnectionHandler(closeCode)
    }
}

extension URLSessionWebSocketTask.Message {
    func convert<T: Codable>() -> T? {
        switch self {
            case .string(let json):
                guard let data = json.data(using: .utf8),
                      let model = try? JSONDecoder().decode(T.self, from: data) else { return nil}
                return model
            case .data(let data):
                guard let model = try? JSONDecoder().decode(T.self, from: data) else { return nil}
                return model
            @unknown default:
                fatalError()
        }
    }
}
