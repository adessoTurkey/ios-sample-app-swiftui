//
//  ExampleUseCase.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 12.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

protocol ExampleUseCaseProtocol {
    func fetchExample() async throws -> ExampleResponse
}

class ExampleUseCase: ExampleUseCaseProtocol {
    let exampleRepository: ExampleRepositoryProtocol

    init(exampleRepository: ExampleRepositoryProtocol = ExampleRepository()) {
        self.exampleRepository = exampleRepository
    }

    func fetchExample() async throws -> ExampleResponse {
        try await exampleRepository.getExample()
    }
}
