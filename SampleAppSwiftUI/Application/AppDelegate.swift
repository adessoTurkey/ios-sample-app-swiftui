//
//  AppDelegate.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 22.02.2023.
//

import UIKit

// This will include methods which the new SwiftUI Lifecycle does not support yet.
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Handle remote notifications here
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Handle remote notification failures here
        LoggerManager().setError(errorMessage: error.localizedDescription)
    }
}
