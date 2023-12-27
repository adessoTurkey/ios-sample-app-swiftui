//
//  CoinNewDataUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService

struct CoinNewDataUIModel: Hashable, Identifiable {
    let id: String
    let imageurl: String
    let title: String
    let url: String
    let body: String
    let source: String

    init(id: String, imageurl: String, title: String, url: String, body: String, source: String) {
        self.id = id
        self.imageurl = imageurl
        self.title = title
        self.url = url
        self.body = body
        self.source = source
    }
}

// MARK: - UIModelProtocol
extension CoinNewDataUIModel: UIModelProtocol {
    init(from responseModel: CoinNewData) {
        self.id = responseModel.id
        self.imageurl = responseModel.imageurl
        self.title = responseModel.title
        self.url = responseModel.url
        self.body = responseModel.body
        self.source = responseModel.source
    }

    init?(from responseModel: CoinNewData?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}
