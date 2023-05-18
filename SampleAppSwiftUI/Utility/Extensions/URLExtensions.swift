//
//  URLExtensions.swift
//  SampleAppSwiftUI
//
//  Created by Marifet, Oguz on 17.05.2023.
//

import Foundation
import UIKit

public extension URL {
    var isDeeplink: Bool {
        scheme == "sampleapp"
    }

    var isUniversalLink: Bool {
        UIApplication.shared.canOpenURL(self)
    }

    var screenType: Screen? {
        guard isDeeplink else { return nil }
        if let host {
            return Screen.init(rawValue: host)
        }
        return nil
    }
}
