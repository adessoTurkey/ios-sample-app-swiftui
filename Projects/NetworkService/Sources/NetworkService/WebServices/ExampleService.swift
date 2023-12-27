//
//  ExampleService.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 16.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

public protocol ExampleServiceProtocol {
    func exampleRequest(requestModel: ExampleRequestModel) async throws -> ExampleResponse
}

public final class ExampleService: ExampleServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = ExampleEndpoints
    var networkLoader: NetworkLoaderProtocol

    public init(networkLoader: NetworkLoaderProtocol = NetworkLoader.shared){
        self.networkLoader = networkLoader
    }

    public func exampleRequest(requestModel: ExampleRequestModel) async throws -> ExampleResponse {
        let urlString = build(endpoint: .example(firstParameter: requestModel.firstParameter,
                                                 secondParameter: requestModel.secondParameter))

        return try await request(with: RequestObject(url: urlString), responseModel: ExampleResponse.self)
    }
}
