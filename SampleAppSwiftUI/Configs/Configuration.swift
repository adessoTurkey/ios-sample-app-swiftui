//
//  Configuration.swift
//  boilerplate-ios-swiftui
//
//  Created by Baha Ulug on 1.12.2020.
//  Copyright © 2020 Adesso Turkey. All rights reserved.
//

import Foundation

final class Configuration: ConfigurationProtocol {
    static var isProduction: Bool {
        #if Production
            return true
        #else
            return false
        #endif
    }

    static var isAppStore: Bool {
        #if AppStore
            return true
        #else
            return false
        #endif
    }

    static var isDevelopment: Bool {
        #if Development
            return true
        #else
            return false
        #endif
    }

    static var baseURL: String {
        let url: String? = try? self.value(for: "base_url")
        return url ?? ""
    }

    static var coinApiKey: String {
        let key: String? = try? self.value(for: "personal_api")
        guard let key, !key.isEmpty else {
            /// Get your API key from https://www.cryptocompare.com/
            return "fee600f44d9b682844543c4b6d0eb5715228f8ca6ac9ba8a87aff4432f1f3fe0"
        }
        return key
    }

    static var webSocketBaseUrl: String {
        let url: String? = try? self.value(for: "webSocket_base_url")
        return url ?? ""
    }
}
