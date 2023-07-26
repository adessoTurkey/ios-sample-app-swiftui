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

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoinDataCD")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
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
//
//    func toggleFavoriteCoin(code: CoinCode) {
//
//        if favoriteCoins.isEmpty {
//            addFavoriteCoin(code: code)
//        } else {
//            if isCoinFavorite(code: code) {
//                removeFavoriteCoin(code: code)
//            } else {
//                addFavoriteCoin(code: code)
//            }
//        }
//    }
//
    func addFavoriteCoin(coin: CoinData) {
        DispatchQueue.main.async {
            let coinCD = CoinDataCD()
            coinCD.title = coin.coinInfo?.title
            coinCD.code = coin.coinInfo?.code
            coinCD.price = coin.detail?.usd?.price ?? 0
            coinCD.price = coin.detail?.usd?.changeAmount ?? 0
            coinCD.price = coin.detail?.usd?.changePercentage ?? 0
            CoreDataManager().save()
        }
    }
    
    func getCoins() -> [CoinData] {
        let fetchRequest: NSFetchRequest<CoinDataCD> = CoinDataCD.fetchRequest()
        
        do {
            return try convert(data: container.viewContext.fetch(fetchRequest))
        } catch {
            return []
        }
    }
    
    func convert(data: [CoinDataCD]) -> [CoinData] {
        var list = [CoinData]()
        for coin in data {
            list.append(CoinData(coinInfo: CoinMarketCapsCoinInfo(code: coin.code, title: coin.title),
                                 detail: CoinRaw(usd: RawUsd(price: coin.price,
                                                             changeAmount: coin.changeAmount,
                                                             changePercentage: coin.changePercentage))))
        }
        return list
    }
//
//    private func removeFavoriteCoin(code: CoinCode) {
//        DispatchQueue.main.async {
//            self.favoriteCoins.removeAll(where: { $0 == code })
//        }
//    }
}
