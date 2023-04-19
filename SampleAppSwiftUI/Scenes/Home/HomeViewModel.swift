//
//  HomeViewModel.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 21.02.2023.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    private var webSocketService: any WebSocketServiceProtocol
    private var cancellable = Set<AnyCancellable>()
    private var reconnectionCount: Int = 0
    private var maxReconnectionCount: Int = 3

    @Published var coinInfo: ExcangeRatesResponseModel?
    @Published var coinList: [CoinInfo] = []
    @Published var filteredCoins: [CoinInfo] = []
    @Published var filterTitle = "Most Popular"

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
            fetchDemoModel()
        }
    }

    private func fetchDemoModel() {
        if let demoDataPath = Bundle.main.path(forResource: "CoinList", ofType: "json") {
            let pathURL = URL(fileURLWithPath: demoDataPath)
            do {
                let data = try Data(contentsOf: pathURL, options: .mappedIfSafe)
                let coinList = try JSONDecoder().decode([CoinInfo].self, from: data)
                self.fillDemoData(coinList: coinList)
            } catch let error {
                print(error)
            }
        }
    }

    private func fillDemoData(coinList: [CoinInfo]) {
        self.coinList = coinList
        self.filteredCoins = coinList
    }

    func filterResults(searchTerm: String) {
        if !searchTerm.isEmpty {
            filteredCoins = coinList.filter { coin in
                coin.title.lowercased().contains(searchTerm.lowercased()) ||
                coin.code.lowercased().contains(searchTerm.lowercased())
            }
        } else {
            filteredCoins = coinList
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
            webservice.sendMessage2(SampleSubscriptionRequest)
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
    }
}
