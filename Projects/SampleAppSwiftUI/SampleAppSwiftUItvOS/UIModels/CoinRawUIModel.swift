//
//  CoinRawUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService

struct CoinRawUIModel: Codable, Hashable {
    var usd: RawUsdUIModel?

    init(usd: RawUsdUIModel? = nil) {
        self.usd = usd
    }

    static func == (lhs: CoinRawUIModel, rhs: CoinRawUIModel) -> Bool {
        lhs.usd == rhs.usd
    }
}

// MARK: - UIModelProtocol
extension CoinRawUIModel: UIModelProtocol {
    init(from responseModel: CoinRaw) {
        self.usd = RawUsdUIModel(from: responseModel.usd)
    }

    init?(from responseModel: CoinRaw?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}
