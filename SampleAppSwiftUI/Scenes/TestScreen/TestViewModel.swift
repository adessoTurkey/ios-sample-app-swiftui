//
//  TestViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 25.04.2023.
//

import Foundation
import SwiftUI
import Combine

class TestViewModel: ObservableObject {
    private var webSocketService: any WebSocketServiceProtocol
    private var cancellable = Set<AnyCancellable>()
    private var reconnectionCount: Int = 0
    private var maxReconnectionCount: Int = 3

    @Published var coinInfo: ExcangeRatesResponseModel?
    @Published var coinList: [CoinInfo] = []
    @Published var filteredCoins: [CoinInfo] = []
    @Published var filterTitle = "Most Popular"
    
    @Published var messages = [Element]()

    init(webSocketService: any WebSocketServiceProtocol = WebSocketService.shared) {
        self.webSocketService = webSocketService
        self.startSocketConnection()
    }

    func startSocketConnection() {
        reconnectionCount = 0
        connect()
    }

    func fillModels(demo: Bool = false) {
        if demo {
//            fetchDemoModel()
        }
        Task {
//            await fetchAllCoins()
        }
    }
    
    private func connect() {
        guard reconnectionCount < maxReconnectionCount,
             let service = webSocketService.connect(endPoint: .baseCoinApi) else {
//            TODO: Connection error
            print("Service connection error.", terminator: "\n*******\n")
            return
        }
        service.setPing(time: 10)
        service.connectionHandler { webservice in
//            webservice.sendMessage2(SampleSubscriptionRequest)
            webservice.sendMessage(<#T##message: WebSocketMessageProtocol##WebSocketMessageProtocol#>)
        } disconnected: { [weak self] closeCode in
            guard let self,
                  closeCode != .goingAway else { return }
            self.reconnectionCount += 1
            self.connect()
        }.receive(on: DispatchQueue.main)
        .sink { _ in }
        receiveValue: { [weak self] socketData in
            guard let self else { return }
            self.webSocketDidReceiveMessage(socketData)
        }.store(in: &cancellable)
    }

    private func webSocketDidReceiveMessage(_ socketResponse: URLSessionWebSocketTask.Message) {
        if let coin: ExcangeRatesResponseModel = socketResponse.convert() {
            self.coinInfo = coin
        } else {
            print("Parse Error", terminator: "\n*******\n")
        }
        print(socketResponse,  terminator: "\n------\n")
        
        switch socketResponse {
        case .string(let text):
//                    self.messages.append(Element(name: text))
            DispatchQueue.main.async {
                self.messages.append(Element(name: text))
            }
        case .data(let data):
            print("******--------******")
            print(socketResponse)
            print("******--------******")
            print(data)
            print("******--------******")
            break
        @unknown default:
            break
        }
        
        
    }
}
