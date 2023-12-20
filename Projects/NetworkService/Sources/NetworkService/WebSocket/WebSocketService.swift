//
//  WebSocketService.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 21.02.2023.
//

import Foundation
import Combine

public protocol WebSocketServiceProtocol: AnyObject, Publisher where Self.Output == URLSessionWebSocketTask.Message, Self.Failure == Error {
    func connect(endPoint: WebSocketEndpoint, loggerManager: LoggerManagerProtocol?) -> (any WebSocketServiceProtocol)?
    func sendMessage(_ message: FavoritesCoinRequest)
    func disconnect()
    func connectionHandler(connected: @escaping (any WebSocketServiceProtocol) -> Void,
                           disconnected: @escaping (URLSessionWebSocketTask.CloseCode) -> Void) -> AnyPublisher<URLSessionWebSocketTask.Message, Error>
    func setPing(time: TimeInterval)
}

public final class WebSocketService: NSObject, WebSocketServiceProtocol {

    public typealias Output = URLSessionWebSocketTask.Message
    public typealias Input =  URLSessionWebSocketTask.Message
    public typealias Failure = Error

    public static let shared = WebSocketService()

    private var stream: WebSocketStream?
    private var disconnectionHandler: (URLSessionWebSocketTask.CloseCode) -> Void = { _ in }
    private var connectionHandler: (any WebSocketServiceProtocol) -> Void = { _ in }
    private var loggerManager: LoggerManagerProtocol?

    private override init() {}

    public func connect(endPoint: WebSocketEndpoint, loggerManager: LoggerManagerProtocol?) -> (any WebSocketServiceProtocol)? {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        guard let provider = WebSocketProvider(endPoint: endPoint, session: session, loggerManager: loggerManager) else {
            return nil
        }
        self.loggerManager = loggerManager
        stream = provider.socket
        return self
    }

    public func receive<S: Subscriber>(subscriber: S) where WebSocketService.Failure == S.Failure, WebSocketService.Output == S.Input {
        guard let stream else { return }
        let subscription = WebSocketSubscription(socket: stream, subscriber: subscriber, loggerManager: self.loggerManager)
        subscriber.receive(subscription: subscription)
    }

    public func connectionHandler(connected: @escaping (any WebSocketServiceProtocol) -> Void,
                           disconnected: @escaping (URLSessionWebSocketTask.CloseCode) -> Void) -> AnyPublisher<URLSessionWebSocketTask.Message, Error> {
        disconnectionHandler = disconnected
        connectionHandler = connected
        return self.eraseToAnyPublisher()
    }

    public func sendMessage(_ message: FavoritesCoinRequest) {
        guard let messageString = message.toJSONString() else { return }
        stream?.send(string: messageString)
    }

    public func disconnect() {
        stream?.cancel(closeCode: .goingAway)
        stream = nil
    }

    public func setPing(time: TimeInterval = 10) {
        stream?.sentPingRegularly = true
        stream?.pingTimeInterval = time
    }
}

extension WebSocketService: URLSessionWebSocketDelegate {
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        connectionHandler(self)
    }

    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        disconnectionHandler(closeCode)
    }
}

public extension URLSessionWebSocketTask.Message {
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
