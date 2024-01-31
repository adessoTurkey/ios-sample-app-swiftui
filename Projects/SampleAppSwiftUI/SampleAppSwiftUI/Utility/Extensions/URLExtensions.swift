//
//  URLExtensions.swift
//  SampleAppSwiftUI
//
//  Created by Marifet, Oguz on 17.05.2023.
//

import Foundation
import UIKit

extension URL {
    var isDeeplink: Bool {
        scheme == "sampleapp"
    }

    var isUniversalLink: Bool {
        UIApplication.shared.canOpenURL(self)
    }

    var screenType: ScreenType? {
        guard isDeeplink else { return nil }
        if let host {
            return ScreenType(rawValue: host)
        }
        return nil
    }
    
    var queryParameters: [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return [:] }
        var parameters = [String: String]()
        for queryItem in queryItems {
            parameters[queryItem.name] = queryItem.value
        }
        return parameters
    }
}
