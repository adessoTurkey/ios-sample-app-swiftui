//
//  SampleAppSwiftUIApp.swift
//  boilerplate-ios-swiftui
//
//  Created by Cagri Gider on 14.08.2022.
//  Copyright © 2022 Adesso Turkey. All rights reserved.
//

import SwiftUI

@main
struct SampleAppSwiftUIApp: App {
    @Environment(\.scenePhase) private var phase
        // Check out https://developer.apple.com/documentation/swiftui/scenephase for more information
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    private var loggingService: LoggingService
    @StateObject private var router = Router()

    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
        loggingService = LoggingService()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(router)
                .onChange(of: phase, perform: { newValue in
                    manageChanges(for: newValue)
                })
                .onOpenURL(perform: onOpenURL(_:))
        }
    }

    private func manageChanges(for phase: ScenePhase) {
        switch phase {
            case .active:
                // App became active
                activated()
            case .background:
                // App is running in the background
                backgrounded()
            case .inactive:
                // App became inactive
                deactivated()
            @unknown default:
                // Fallback for future cases
                break
        }
    }
}

// MARK: - App Life Cycle
 extension SampleAppSwiftUIApp {
     func activated() {}
     func backgrounded() {}
     func deactivated() {}
     func onOpenURL(_ url: URL) {
         router.onOpenURL(url)
     }
 }
