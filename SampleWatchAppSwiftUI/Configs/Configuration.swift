//
//  Configuration.swift
//  SampleWatchAppSwiftUI
//
//  Created by Yildirim, Alper on 17.10.2023.
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
        return  url ?? ""
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

    static var appGroupName: String {
        let key: String? = try? self.value(for: "app_group_name")
        return key ?? ""
    }
}

protocol ConfigurationProtocol {}

extension ConfigurationProtocol {
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw ConfigurationError.missingKey
        }

        switch object {
            case let value as T:
                return value
            case let string as String:
                guard let value = T(string) else { fallthrough }
                return value
            default:
                throw ConfigurationError.invalidValue
        }
    }
}

enum ConfigurationError: Swift.Error {
    case missingKey, invalidValue
}
