//
//  ViewModelProtocol.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 5.07.2023.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var filteredCoins: [CoinData] { get set }
    var coinList: [CoinData] { get }
    var selectedSortOption: SortOptions { get set }

    func checkLastItem(_ item: CoinData)
}

extension ViewModelProtocol {
    func checkLastItem(_ item: CoinData) {}
    func sortOptions(sort: SortOptions) {
        switch sort {
            case .mostPopular:
                filteredCoins = coinList
            case .price:
                filteredCoins = filteredCoins.sorted {
                    $0.detail?.usd?.price ?? 0 < $1.detail?.usd?.price ?? 0
                }
            case .priceReversed:
                filteredCoins = filteredCoins.sorted {
                    $0.detail?.usd?.price ?? 0 > $1.detail?.usd?.price ?? 0
                }
            case .name:
                filteredCoins = filteredCoins.sorted {
                    $0.coinInfo?.code ?? "" < $1.coinInfo?.code ?? ""
                }
            case .nameReversed:
                filteredCoins = filteredCoins.sorted {
                    $0.coinInfo?.code ?? "" > $1.coinInfo?.code ?? ""
            }
        }
    }
}
