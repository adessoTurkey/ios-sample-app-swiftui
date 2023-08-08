//
//  ViewModelProtocol.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 5.07.2023.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var selectedSortOption: SortOptions { get set }

    func checkLastItem(_ item: CoinData)
}

extension ViewModelProtocol {
    func checkLastItem(_ item: CoinData) {}
}
