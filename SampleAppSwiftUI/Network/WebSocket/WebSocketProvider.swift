//
//  WebSocketProvider.swift
//  SampleAppSwiftUI
//
//  Created by Bozkurt, Umit on 17.02.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

class WebSocketProvider: NSObject {

    var socket: WebSocketStream

    init? (endPoint: TargetEndpointProtocol = WebSocketEndpoint.baseCoinApi,
           session: URLSession = URLSession.shared ) {
        guard let url = URL(string: WebSocketEndpoint.baseCoinApi.path) else { return nil }
        self.socket = WebSocketStream(url: url,
                                      session: session)
    }
}
