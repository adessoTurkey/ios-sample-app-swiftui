//
//  WebSocketStream.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 15.02.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

class WebSocketStream: NSObject, AsyncSequence {
    typealias SocketStream = AsyncThrowingStream<Element, Error>
    typealias Element = URLSessionWebSocketTask.Message
    typealias AsyncIterator = SocketStream.Iterator

    private lazy var stream: SocketStream = {
        SocketStream { continuation in
            self.continuation = continuation
            self.continuation?.onTermination = { @Sendable [task] _ in
                task.cancel()
            }
        }
    }()

    private var continuation: SocketStream.Continuation?
    private let task: URLSessionWebSocketTask

    init(url: URL, session: URLSession = URLSession.shared) {
        task = session.webSocketTask(with: url)
    }

    deinit {
        continuation?.finish()
    }

    func makeAsyncIterator() -> AsyncIterator {
        task.resume()
        waitForNextValue()
        return stream.makeAsyncIterator()
    }

    private func waitForNextValue() {
        guard task.closeCode == .invalid else {
            continuation?.finish()
            return
        }

        task.receive(completionHandler: { [weak self] result in
            guard let self,
                let continuation = self.continuation else {
                return
            }

            do {
                let message = try result.get()
                continuation.yield(message)
                self.waitForNextValue()
            } catch {
                continuation.finish(throwing: error)
            }
        })
    }

    func cancel(closeCode: URLSessionWebSocketTask.CloseCode) {
        task.cancel(with: closeCode, reason: nil)
        continuation?.finish()
    }

    func send(string: String) {
        let message = URLSessionWebSocketTask.Message.string(string)
        _ = Task {
            try? await task.send(message)
        }
    }

    func send(data: Data) async throws {
        let message = URLSessionWebSocketTask.Message.data(data)
        _ = Task {
            try? await task.send(message)
        }
    }
}
