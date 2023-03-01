//
//  WebSocketService.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 21.02.2023.
//

import Foundation

protocol WebSocketServiceProtocol {
    func connect(endPoint: WebSocketEndpoint) throws -> WebSocketStream
    func sendMessage(_ message: WebSocketMessageProtocol)
    func disconnect()
}

final class WebSocketService: WebSocketServiceProtocol {
    static let shared = WebSocketService()
    private var stream: WebSocketStream?

    private init() {}

    func connect(endPoint: WebSocketEndpoint) throws -> WebSocketStream {
        guard let provider = WebSocketProvider(endPoint: endPoint) else {
            throw AdessoError.badURL(endPoint.path)
        }

        stream = provider.socket
        guard let stream else {
            throw AdessoError.badURL(endPoint.path)
        }
        return stream
    }

    func sendMessage(_ message: WebSocketMessageProtocol) {
        guard let messageString = message.toJSONString() else { return }
        stream?.send(string: messageString)
    }

    func disconnect() {
        stream?.cancel(closeCode: .goingAway)
        stream = nil
    }
}
