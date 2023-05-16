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
        ""
    }

    static var allCoinBaseUrl: String {
        let url: String? = try? self.value(for: "all_coin_base_url")
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
