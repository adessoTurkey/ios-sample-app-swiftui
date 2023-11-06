//
//  StorageManager.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 4.04.2023.
//

import SwiftUI
import WatchConnectivity

final class StorageManager: NSObject, ObservableObject {

    static let shared = StorageManager()

    private let watchSession = WCSession.default

    @AppStorage("favoriteCoins", store: .standard)
    var favoriteCoins: [CoinData] = [] {
        didSet {
            sendFavoritesToWatchApp()
        }
    }

    override init() {
        super.init()
        initWatchConnection()
    }

    func isCoinFavorite(_ coinCode: CoinCode) -> Bool {
        favoriteCoins.contains { coinData in
            if let coinInfo = coinData.coinInfo, let code = coinInfo.code {
                return code == coinCode
            }
            return false
        }
    }

    func toggleFavoriteCoin(coinData: CoinData) {
        if favoriteCoins.isEmpty {
            addFavoriteCoin(coinData: coinData)
        } else {
            if isCoinFavorite(coinData.coinInfo?.code ?? "") {
                removeFavoriteCoin(coinData.coinInfo?.code ?? "")
            } else {
                addFavoriteCoin(coinData: coinData)
            }
        }
    }

    private func sendFavoritesToWatchApp() {
        if watchSession.isReachable {
            guard let data: Data = favoriteCoins.encode() else { return }
            let message = ["favoriteCoinsData": data]

            watchSession.sendMessage(message, replyHandler: { response in
                print(response)
            }, errorHandler: { error in
                print(error)
            })
        }
    }

    private func addFavoriteCoin(coinData: CoinData) {
        DispatchQueue.main.async {
            self.favoriteCoins.append(coinData)
        }
    }

    private func removeFavoriteCoin(_ coinCode: CoinCode) {
        favoriteCoins.removeAll { coinData in
            if let coinInfo = coinData.coinInfo, let code = coinInfo.code {
                return code == coinCode
            }
            return false
        }
    }

    @discardableResult
    func manageFavorites(coinData: CoinData) -> String {
        let output = isCoinFavorite(coinData.coinInfo?.code ?? "") ? "Removed from Favorites" : "Added to Favorites"
        toggleFavoriteCoin(coinData: coinData)
        return output
    }
}

extension StorageManager: WCSessionDelegate {

    func initWatchConnection() {
        if watchSession.activationState == .notActivated {
            watchSession.delegate = self
            watchSession.activate()
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("got message: \(message)")
        replyHandler(message)
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activated: \(activationState)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("inactive: \(session)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("deactivated: \(session)")
    }
}
