//
//  AllCoinUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService

struct AllCoinUIModel: Hashable, Identifiable {
    var id: String
    let data: [CoinUIModel]?

    init(id: String, data: [CoinUIModel]?) {
        self.id = id
        self.data = data
    }
}

// MARK: - UIModelProtocol
extension AllCoinUIModel: UIModelProtocol {
    init(from responseModel: AllCoinResponse) {
        self.id = responseModel.id
        self.data = responseModel.data?.compactMap({ CoinUIModel(from: $0) })
    }

    init?(from responseModel: AllCoinResponse?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}
