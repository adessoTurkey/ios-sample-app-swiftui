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
        guard let url = URL(string: "wss://streamer.cryptocompare.com/v2?api_key=df454843b965ac85d1bbd7a47d3d55c8c3d4e0c6a869f6f4c7a4e93a4bdba0a2") else { return }
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        receiveMessage()
    }
    
     private func receiveMessage() {
        webSocketTask?.receive { result in
            print("************")
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
                    print("************")
                    print(result)
                    print("************")
                    print(data)
                    print("************")
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    func sendMessage() {
        let req = SubscriptionRequest(action: "SubAdd" , subs: ["0~Coinbase~BTC~USD"])
        guard let data = try? PropertyListEncoder.init().encode(req) else { return }
//        print(req, terminator: "\n**----**\n")
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
