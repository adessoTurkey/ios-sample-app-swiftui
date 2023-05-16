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
        guard let url = URL(string: "wss://streamer.cryptocompare.com/v2?api_key=850c771ef83eef797b910583fd0ae30582b9046270a2b5b7368ccb58b51e05a4") else { return nil }
        self.socket = WebSocketStream(url: url,
                                      session: session)
    }
}
