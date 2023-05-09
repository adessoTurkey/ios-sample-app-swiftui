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
//    private var webSocketService: any WebSocketServiceProtocol
//    private var cancellable = Set<AnyCancellable>()
//    private var reconnectionCount: Int = 0
//    private var maxReconnectionCount: Int = 3

    @Published var coinInfo: ExcangeRatesResponseModel?
    @Published var coinList: [CoinData] = []
    @Published var filteredCoins: [CoinData] = []
    @Published var filterTitle = "Most Popular"

//    init(webSocketService: any WebSocketServiceProtocol = WebSocketService.shared) {
//        self.webSocketService = webSocketService
////        self.startSocketConnection()
//    }
//
//    func startSocketConnection() {
//        reconnectionCount = 0
////        connect()
//    }

    func fillModels(demo: Bool = false) async {
        if demo {
            fetchDemoModel()
        }
        await fetchAllCoins()
    }

    private func fetchAllCoins() async {
        guard let dataSource = try? await AllCoinRemoteDataSource().getAllCoin(limit: 30, unitToBeConverted: "USD", page: 1) else {
            print("Problem on the convert")
            return
        }
        DispatchQueue.main.async {
            if let data = dataSource.data {
                self.coinList = data
                self.filteredCoins = data
            }
        }
    }

    private func fetchDemoModel() {
        if let demoDataPath = Bundle.main.path(forResource: "CoinList", ofType: "json") {
            let pathURL = URL(fileURLWithPath: demoDataPath)
            do {
                let data = try Data(contentsOf: pathURL, options: .mappedIfSafe)
                let coinList = try JSONDecoder().decode([CoinData].self, from: data)
                self.fillDemoData(coinList: coinList)
            } catch let error {
                print(error)
            }
        }
    }

    private func fillDemoData(coinList: [CoinData]) {
        self.coinList = coinList
        self.filteredCoins = coinList
    }

    func filterResults(searchTerm: String) {
        if !searchTerm.isEmpty {
            filteredCoins = coinList.filter { coin in
                if let coinInfo = coin.coinInfo,
                   let title = coinInfo.title,
                   let code = coinInfo.code {
                    return title.lowercased().contains(searchTerm.lowercased()) ||
                    code.lowercased().contains(searchTerm.lowercased())
                } else {
                    return false
                }
            }
        } else {
            filteredCoins = coinList
        }
    }

//    private func connect() {
//        guard reconnectionCount < maxReconnectionCount,
//             let service = webSocketService.connect(endPoint: .baseCoinApi) else {
////            TODO: Connection error
//            print("Service connection error.", terminator: "\n*******\n")
//            return
//        }
//        service.setPing(time: 10)
//        service.connectionHandler { webservice in
//            webservice.sendMessage2(sampleSubscriptionRequest)
//        } disconnected: { [weak self] closeCode in
//            guard let self,
//                  closeCode != .goingAway else { return }
//            self.reconnectionCount += 1
//            self.connect()
//        }.receive(on: DispatchQueue.main)
//        .sink { _ in }
//        receiveValue: { [weak self] socketData in
//            guard let self else { return }
//            self.webSocketDidReceiveMessage(socketData)
//        }.store(in: &cancellable)
//    }
//
//    private func webSocketDidReceiveMessage(_ socketResponse: URLSessionWebSocketTask.Message) {
//        if let coin: ExcangeRatesResponseModel = socketResponse.convert() {
//            self.coinInfo = coin
//        } else {
//            print("Parse Error", terminator: "\n*******\n")
//        }
//        print(socketResponse, terminator: "\n------\n")
//    }
}
