//
//  NetworkLoader.swift
//  SampleAppSwiftUI
//
//  Created by Saglam, Fatih on 10.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

public class NetworkLoader: NetworkLoaderProtocol {
    public static let shared = NetworkLoader()

    public var session: URLSessionProtocol = URLSession.shared
    public var decoder: JSONDecoder = JSONDecoder()
}
