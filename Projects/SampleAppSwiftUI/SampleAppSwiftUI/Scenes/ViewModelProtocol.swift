//
//  ViewModelProtocol.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 5.07.2023.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var filteredCoins: [CoinUIModel] { get set }
    var coinList: [CoinUIModel] { get }
    var selectedSortOption: SortOptions { get set }

    func checkLastItem(_ item: CoinUIModel)
}

extension ViewModelProtocol {
    func checkLastItem(_ item: CoinUIModel) {}

    func sortOptions(sort: SortOptions) {
        selectedSortOption = sort
        switch sort {
            case .defaultList:
                filteredCoins = filteredCoins.count < coinList.count ? filteredCoins : coinList
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
