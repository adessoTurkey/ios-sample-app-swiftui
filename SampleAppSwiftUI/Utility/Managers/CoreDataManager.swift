//
//  CoreDataManager.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 25.07.2023.
//

import SwiftUI
import Foundation
import CoreData

final class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    var list = [CoinDataCD]()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoinDataModel")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        fetchRaw()
    }

    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Core Data save Erorr")
            }
        }
    }

    func toggleFavoriteCoin(coinData: CoinData) {

        if list.isEmpty {
            addFavoriteCoin(coin: coinData)
        } else {
            if isCoinFavorite(coinData.coinInfo?.code ?? "") {
                removeFavoriteCoin(code: coinData.coinInfo?.code ?? "")
            } else {
                addFavoriteCoin(coin: coinData)
            }
        }
    }

    func isCoinFavorite(_ coinCode: CoinCode) -> Bool {
        list.contains { coinData in
            if let code = coinData.code {
                return code == coinCode
            }
            return false
        }
    }

    func addFavoriteCoin(coin: CoinData) {
        let context = container.viewContext
        let coinCD = CoinDataCD(context: context)
        coinCD.title = coin.coinInfo?.title
        coinCD.code = coin.coinInfo?.code
        coinCD.price = coin.detail?.usd?.price ?? 0
        coinCD.changeAmount = coin.detail?.usd?.changeAmount ?? 0
        coinCD.changePercentage = coin.detail?.usd?.changePercentage ?? 0
        list.append(coinCD)
        self.save()
    }

    func fetchRaw() {
        let fetchRequest: NSFetchRequest<CoinDataCD> = CoinDataCD.fetchRequest()
        list = (try? container.viewContext.fetch(fetchRequest)) ?? []
    }

    func getCoins() -> [CoinData] {
        convert(from: list)
    }

    func convert(from: [CoinDataCD]) -> [CoinData] {
        var list = [CoinData]()
        for coin in from {
            list.append(CoinData(coinInfo: CoinMarketCapsCoinInfo(code: coin.code, title: coin.title),
                                 detail: CoinRaw(usd: RawUsd(price: coin.price,
                                                             changeAmount: coin.changeAmount,
                                                             changePercentage: coin.changePercentage))))
        }
        return list
    }

    private func removeFavoriteCoin(code: CoinCode) {
        let context = container.viewContext
        guard let coin = list.first(where: { $0.code == code }) else {
            return
        }
        list.removeAll { $0.code == code }
        context.delete(coin)
        save()
    }

    @discardableResult
    func manageFavorites(coinData: CoinData) -> String {
        let output = isCoinFavorite(coinData.coinInfo?.code ?? "") ? "Removed from Favorites" : "Added to Favorites"
        toggleFavoriteCoin(coinData: coinData)
        return output
    }
}
