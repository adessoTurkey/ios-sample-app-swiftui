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
           session: URLSession = URLSession.shared, loggerManager: LoggerManagerProtocol?) {
        guard let url = URL(string: WebSocketEndpoint.baseCoinApi.path) else { return nil }
        let query = URLQueryItem(name: "api_key", value: Configuration.coinApiKey)
        let finalURL = url.appending(queryItems: [query])
        self.socket = WebSocketStream(url: finalURL,
                                      session: session, loggerManager: loggerManager)
    }
}
