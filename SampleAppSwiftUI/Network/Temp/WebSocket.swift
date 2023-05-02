//
//  WebSocket.swift
//  SwiftUI_websocket_learning
//
//  Created by Uslu, Teyhan on 17.04.2023.
//

import Foundation

@MainActor class Websocket: ObservableObject {
    @Published var messages = [Element]()

    private var webSocketTask: URLSessionWebSocketTask?

    init() {
        self.connect()
    }

    private func connect() {
        guard let url = URL(string: "wss://streamer.cryptocompare.com/v2?api_key=\(Configuration.coinApiKey)") else { return }
//        let url = WebSocketEndpoint.baseCoinApi.path
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        receiveMessage()
    }

     private func receiveMessage() {
        webSocketTask?.receive { result in
            print("***--------******")
            print(result)
            switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let message):
                switch message {
                    case .string(let text):
    //                    self.messages.append(Element(name: text))
                        DispatchQueue.main.async {
                            self.messages.append(Element(name: text))
                        }
                    case .data(let data):
                        print("******--------******")
                        print(result)
                        print("******--------******")
                        print(data)
                        print("******--------******")
                    @unknown default:
                        break
                }
            }
        }
    }

    func sendMessage() {
        let req = OldSubscriptionRequest(action: "SubAdd", subs: ["0~Coinbase~BTC~USD"])
        guard let data = try? PropertyListEncoder.init().encode(req) else { return }
        print(req, terminator: "\n**----**\n")
        let taskData = URLSessionWebSocketTask.Message.data(data)
        webSocketTask?.send(taskData) { error in
          if let error = error {
            print("WebSocket couldn’t send message because: \(error)")
          }
        }
        receiveMessage()
    }

    func sendMessage2() {
        let message = URLSessionWebSocketTask.Message.string(sampleReq)
        webSocketTask?.send(message) { error in
          if let error = error {
            print("WebSocket couldn’t send message because: \(error)")
          }
        }
        receiveMessage()
    }
}

struct Element: Identifiable {
    let id = UUID()
    let name: String
}
