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

    private var pingTimer: Timer?
    var pingTimeInterval: TimeInterval = 10
    var sentPingRegularly: Bool = false

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
        pingTimer?.invalidate()
        continuation?.finish()
    }

    func makeAsyncIterator() -> AsyncIterator {
        task.resume()
        waitForNextValue()
        DispatchQueue.main.async {
            self.schedulePing()
        }
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
        pingTimer?.invalidate()
        continuation?.finish()
    }

    func send(string: String) {
        let message = URLSessionWebSocketTask.Message.string(string)
        send(message: message)
    }

    func send(data: Data) async throws {
        let message = URLSessionWebSocketTask.Message.data(data)
        send(message: message)
    }

    private func send(message: URLSessionWebSocketTask.Message) {
        guard task.closeCode == .invalid else {
            continuation?.finish()
            return
        }

        _ = Task {
            try? await task.send(message)
        }
    }

    func schedulePing() {
        guard sentPingRegularly else {
            pingTimer?.invalidate()
            return
        }

        pingTimer = Timer.scheduledTimer(withTimeInterval: pingTimeInterval, repeats: true) { [weak self] timer in
            guard let self else { return }
            self.task.sendPing { error in
                if let error {
                    debugPrint("Pong Error: ", error)
                    timer.invalidate()
                } else {
                    debugPrint("Connection is alive")
                }
            }
        }
    }
}
