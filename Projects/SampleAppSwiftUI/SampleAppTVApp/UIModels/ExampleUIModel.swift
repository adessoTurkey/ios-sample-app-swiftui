//
//  ExampleUIModel.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation
import NetworkService

struct ExampleUIModel {
    let value: String?

    init(value: String?) {
        self.value = value
    }
}

// MARK: - UIModelProtocol
extension ExampleUIModel: UIModelProtocol {
    init(from responseModel: ExampleResponse) {
        self.value = responseModel.value
    }

    init?(from responseModel: ExampleResponse?) {
        guard let responseModel else { return nil }
        self.init(from: responseModel)
    }
}
