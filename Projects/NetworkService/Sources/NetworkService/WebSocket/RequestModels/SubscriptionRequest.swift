//
//  WebSocketSubscriptionRequest.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 19.04.2023.
//

import Foundation

public struct SubscriptionRequest: Codable {
    let action: String
    let subs: [String]
}
