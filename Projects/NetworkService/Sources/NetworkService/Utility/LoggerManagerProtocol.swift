//
//  LoggerManagerProtocol.swift
//  NetworkService
//
//  Created by Abay, Batuhan on 7.12.2023.
//

import Foundation

public protocol LoggerManagerProtocol {
    func setVerbose(_ message: String)
    func setDebug(_ message: String)
    func setInfo(_ message: String)
    func setWarn(_ message: String)
    func setError(_ message: String)
}
