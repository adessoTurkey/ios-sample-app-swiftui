//
//  WebSocketProvider.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 17.02.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

class WebSocketProvider {

    var socket: WebSocketStream

    init? (endPoint: TargetEndpointProtocol = WebSocketEndpoint.baseCoinApi) {
        guard let url = URL(string: endPoint.path) else { return nil }
        self.socket = WebSocketStream(url: url,
                                      session: URLSession.shared)
    }
}
