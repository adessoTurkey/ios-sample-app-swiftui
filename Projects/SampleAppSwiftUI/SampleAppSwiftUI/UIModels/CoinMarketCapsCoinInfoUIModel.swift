//
//  CoinMarketCapsCoinInfoUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService

struct CoinMarketCapsCoinInfoUIModel: Codable, Hashable {
    let code: String?
    var title: String?

    init(code: String?, title: String? = nil) {
        self.code = code
        self.title = title
    }

    static func == (lhs: CoinMarketCapsCoinInfoUIModel, rhs: CoinMarketCapsCoinInfoUIModel) -> Bool {
        lhs.code == rhs.code
    }
}

// MARK: - UIModelProtocol
extension CoinMarketCapsCoinInfoUIModel: UIModelProtocol {
    init(from responseModel: CoinMarketCapsCoinInfo) {
        self.code = responseModel.code
        self.title = responseModel.title
    }

    init?(from responseModel: CoinMarketCapsCoinInfo?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}
