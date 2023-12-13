//
//  BaseServiceProtocol.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 11.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

protocol BaseServiceProtocol {
    associatedtype Endpoint: TargetEndpointProtocol

    var networkLoader: NetworkLoaderProtocol { get }

    func request<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> T
    func authenticatedRequest<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> T
}

extension BaseServiceProtocol {

    func request<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> T {
        try await networkLoader.request(with: requestObject, responseModel: responseModel)
    }

    func build(endpoint: Endpoint) -> String {
        endpoint.path
    }

    func authenticatedRequest<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> T {
        var requestObject = requestObject
        return try await networkLoader.request(with: prepareAuthenticatedRequest(with: &requestObject), responseModel: responseModel)
    }

    private func prepareAuthenticatedRequest(with requestObject: inout RequestObject) -> RequestObject {
        // TODO: - handle authenticatedRequest with urlSession

        requestObject
    }
}
