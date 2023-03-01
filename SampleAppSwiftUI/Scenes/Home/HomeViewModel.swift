//
//  HomeViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 21.02.2023.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var btcPrice: String = "Test0"
    private var webSocketService: WebSocketServiceProtocol

    init(webSocketService: WebSocketServiceProtocol = WebSocketService.shared) {
        self.webSocketService = webSocketService
    }

    func startSocketConnection() async {
        guard let stream = try? webSocketService.connect(endPoint: .baseCoinApi) else { return }
        let excangeMessage = WebSocketExcangeRatesMessage()
        webSocketService.sendMessage(excangeMessage)
        await listenSocket(stream)
    }

    private func listenSocket(_ stream: WebSocketStream) async {
        do {
            for try await message in stream {
                switch message {
                    case .string(let json):
                        webSocketDidReceiveMessage(string: json)
                    case .data:
                        break
                    @unknown default:
                        break
                }
            }
        } catch {
            debugPrint("Someting went wrong")
        }
    }

    private func webSocketDidReceiveMessage(string: String) {
        debugPrint("ReceiveMessage: ", string)
        guard let data = string.data(using: .utf8) else { return }
        DispatchQueue.main.async {
            let excangeRatesResponseModel = try? JSONDecoder().decode(ExcangeRatesResponseModel.self, from: data)
            self.btcPrice = "\(Int(excangeRatesResponseModel?.rate ?? 0))"
        }
    }
}
