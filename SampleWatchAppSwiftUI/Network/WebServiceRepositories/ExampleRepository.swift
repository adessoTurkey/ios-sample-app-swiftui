//
//  ExampleRepository.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 13.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

protocol ExampleRepositoryProtocol {
    func getExample() async throws -> ExampleResponse
}

class ExampleRepository: ExampleRepositoryProtocol {
    let exampleRemoteDataSource: ExampleRemoteDataSourceProtocol

    init(exampleRemoteDataSource: ExampleRemoteDataSourceProtocol = ExampleRemoteDataSource()) {
        self.exampleRemoteDataSource = exampleRemoteDataSource
    }

    func getExample() async throws -> ExampleResponse {
        try await exampleRemoteDataSource.getExample()
    }
}
