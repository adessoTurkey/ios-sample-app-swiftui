//
//  WebSocketSubscription.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 14.03.2023.
//

import Foundation
import Combine

class WebSocketSubscription<S: Subscriber>: Subscription where S.Input == URLSessionWebSocketTask.Message, S.Failure == Error {

    private var socket: WebSocketStream
    private var subscriber: S?
    private var loggerManager: LoggerManagerProtocol?

    init(socket: WebSocketStream, subscriber: S, loggerManager: LoggerManagerProtocol?) {
        self.loggerManager = loggerManager
        self.subscriber = subscriber
        self.socket = socket
        listen()
    }

    func request(_ demand: Subscribers.Demand) {
        // Adjust the demand in case you need to
    }

    func cancel() {
        subscriber = nil
    }

    private func listen() {
        _ = Task {
            await listenSocket()
        }
    }

    private func listenSocket() async {
        guard let subscriber = subscriber else {
            loggerManager?.setError("no subscriber")
            return
        }
        do {
            for try await message in socket {
                _ = subscriber.receive(message)
            }
        } catch let error {
            loggerManager?.setError("Something went wrong \(error.localizedDescription)")
        }
    }
}
