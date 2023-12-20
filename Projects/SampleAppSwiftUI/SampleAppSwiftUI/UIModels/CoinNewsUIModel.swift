//
//  CoinNewsUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService

struct CoinNewsUIModel: Hashable, Identifiable {
    var id: UUID
    let type: Int
    let message: String
    let data: [CoinNewDataUIModel]?
    let hasWarning: Bool

    init(id: UUID, type: Int, message: String, data: [CoinNewDataUIModel]?, hasWarning: Bool) {
        self.id = id
        self.type = type
        self.message = message
        self.data = data
        self.hasWarning = hasWarning
    }
}

// MARK: - UIModelProtocol
extension CoinNewsUIModel: UIModelProtocol {
    init(from responseModel: CoinNewsResponse) {
        self.id = responseModel.id
        self.type = responseModel.type
        self.message = responseModel.message
        self.data = responseModel.data?.compactMap({ CoinNewDataUIModel(from: $0) })
        self.hasWarning = responseModel.hasWarning
    }

    init?(from responseModel: CoinNewsResponse?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}
