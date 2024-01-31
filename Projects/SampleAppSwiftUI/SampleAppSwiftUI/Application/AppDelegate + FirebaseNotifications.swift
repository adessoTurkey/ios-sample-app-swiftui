//
//  AppDelegate + FirebaseNotifications.swift
//  SampleAppSwiftUI
//
//  Created by Cakir, Faik on 27.12.2023.
//

import UIKit
import FirebaseMessaging

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        process(response.notification)
        completionHandler()
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        LoggerManager.shared.setError(errorMessage: error.localizedDescription)
    }
    
    func process(_ notification: UNNotification) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        let userInfo = notification.request.content.userInfo
        guard let id = userInfo["id"] as? String,
              let code = userInfo["code"] as? String,
              let title = userInfo["title"] as? String,
              let price = userInfo["price"] as? String,
              let changeAmount = userInfo["changeAmount"] as? String,
              let changePercentage = userInfo["changePercentage"] as? String
        else { return }

        let parameters: [String: String] = [
            "id": id,
            "code": code,
            "title": title,
            "price": price,
            "changeAmount": changeAmount,
            "changePercentage": changePercentage
        ]

        var urlComponents = URLComponents()
        urlComponents.scheme = "sampleapp"
        urlComponents.host = "1"
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        if let url = urlComponents.url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
