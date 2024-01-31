//
//  AppDelegate.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 22.02.2023.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

// This will include methods which the new SwiftUI Lifecycle does not support yet.
class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if (Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil) {
            FirebaseApp.configure()
            FirebaseConfiguration.shared.setLoggerLevel(.min)
        }
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { _, _ in }
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        return true
    }
}
