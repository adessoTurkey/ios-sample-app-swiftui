//
//  Configuration.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 6.12.2023.
//

import Foundation

final class Configuration: ConfigurationProtocol {
    static var baseURL: String {
        let url: String? = try? self.value(for: "base_url")
        return url ?? ""
    }

    static var coinApiKey: String {
        let key: String? = try? self.value(for: "personal_api")
        guard let key, !key.isEmpty else {
            /// Get your API key from https://www.cryptocompare.com/
            #warning("Please Enter an API Key")
            return ""
        }
        return key
    }

    static var webSocketBaseUrl: String {
        let url: String? = try? self.value(for: "webSocket_base_url")
        return url ?? ""
    }
}
