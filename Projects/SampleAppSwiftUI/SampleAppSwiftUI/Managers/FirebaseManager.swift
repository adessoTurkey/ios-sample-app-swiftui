//
//  FirebaseManager.swift
//  SampleAppSwiftUI
//
//  Created by Cakir, Faik on 26.12.2023.
//

import Foundation
import FirebaseRemoteConfig
import FirebaseCrashlytics
import FirebaseAnalytics

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    //TODO: When uploading app to store, first set minimumFetchInterval to 43200 seconds and run, after remove this function and implementations.
    private func activateDebugMode() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues() async throws -> String {
        activateDebugMode()
        
        return try await withCheckedThrowingContinuation { continuation in
            RemoteConfig.remoteConfig().fetch { _, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                RemoteConfig.remoteConfig().activate { _, _ in
                    if let configValue = RemoteConfig.remoteConfig().configValue(forKey: "version_number").stringValue {
                        continuation.resume(returning: configValue)
                    } else {
                        continuation.resume(throwing: NSError(domain: "Firebase Remote Config", code: 0, userInfo: nil))
                    }
                }
            }
        }
    }
    
    func sendNonFatal(error: Error) async {
        Crashlytics.crashlytics().record(error: error)
    }
    
    func logEvent(name: String, params: [String: Any]? = nil) async {
        Analytics.logEvent(name, parameters: params)
    }
}
