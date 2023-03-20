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

    init(socket: WebSocketStream, subscriber: S) {
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
            debugPrint("no subscriber")
            return }
        do {
            for try await message in socket {
                _ = subscriber.receive(message)
            }
        } catch {
            debugPrint("Someting went wrong")
        }
    }
}
