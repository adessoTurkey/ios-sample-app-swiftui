//
//  LoggerManager.swift
//  boilerplate-ios-swiftui
//
//  Created by Baha Ulug on 3.12.2020.
//  Copyright © 2020 Adesso Turkey. All rights reserved.
//

import CocoaLumberjack
import CocoaLumberjackSwiftLogBackend
import Logging
import NetworkService

class LoggerManager {

    static let shared = LoggerManager()

    private enum Constants {
        static let secondsInOneDay: TimeInterval = 60 * 60 * 24
        static let bytesInTenMegabytes: UInt64 = 1024 * 10
        static let maximumFileSize: UInt = 7
    }

    private let logger = Logger()
    private var fileLogger: DDFileLogger?

    private init() {}

    func setLogLevel(_ logLevel: LogLevel) {
        logger.setLogLevel(logLevel)
    }

    func setup(level: LogLevel = .debug, directoryPath: String? = nil) {
        let ddosLogger = DDOSLogger.sharedInstance
        guard let documentsDirectory = directoryPath ?? NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                                                            FileManager.SearchPathDomainMask.userDomainMask,
                                                                                            true).first else { return }

        logger.setLogLevel(level)
        DDLog.add(ddosLogger)
        LoggingSystem.bootstrapWithCocoaLumberjack()

        let fileManager = DDLogFileManagerDefault(logsDirectory: documentsDirectory)
        fileLogger = DDFileLogger(logFileManager: fileManager)

        if let fileLogger = fileLogger {
            fileLogger.rollingFrequency = Constants.secondsInOneDay
            fileLogger.maximumFileSize = Constants.bytesInTenMegabytes
            fileLogger.logFileManager.maximumNumberOfLogFiles = Constants.maximumFileSize
            DDLog.add(fileLogger)
        }
    }

    func getLogData() -> [Data] {
        guard let fileLogger = fileLogger else { return [] }
        let logFilePaths = fileLogger.logFileManager.sortedLogFilePaths
        var logFileDataArray = [Data]()
        for logFilePath in logFilePaths {
            let fileURL = URL(fileURLWithPath: logFilePath)
            if let logFileData = try? Data(contentsOf: fileURL, options: Data.ReadingOptions.mappedIfSafe) {
                logFileDataArray.insert(logFileData, at: 0)
            }
        }
        return logFileDataArray
    }

    func setInfo(version: String, build: String, deviceModel: String, osVersion: String) {
        logger.info("Application started. Version: \(version), Build: \(build), Device: \(deviceModel), iOS: \(osVersion)")
    }

    func setError(errorMessage: String) {
        logger.error(errorMessage)
    }
}

// MARK: - NetworkService - LoggerManagerProtocol Implementation
extension LoggerManager: LoggerManagerProtocol {
    func setVerbose(_ message: String) {
        logger.verbose(message)
    }

    func setDebug(_ message: String) {
        logger.debug(message)
    }

    func setInfo(_ message: String) {
        logger.info(message)
    }

    func setWarn(_ message: String) {
        logger.warn(message)
    }

    func setError(_ message: String) {
        logger.error(message)
    }
}
