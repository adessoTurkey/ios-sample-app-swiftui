//
//  LoggingService.swift
//  boilerplate-ios-swiftui
//
//  Created by Baha Ulug on 3.12.2020.
//  Copyright © 2020 Adesso Turkey. All rights reserved.
//

import UIKit

class LoggingService {

    init() {
        LoggerManager.shared.setup(level: .debug)
        logApplicationAndDeviceInfo()
    }

    private func logApplicationAndDeviceInfo() {
        let version = UIApplication.appVersion
        let build = UIApplication.appBuild
        let deviceModel = UIDevice.modelName
        let osVersion = UIDevice.osVersion

        LoggerManager.shared.setInfo(version: version, build: build, deviceModel: deviceModel, osVersion: osVersion)
    }
}
