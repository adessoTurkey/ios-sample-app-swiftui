//
//  SampleAppTVApp.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 28.12.2023.
//

import SwiftUI
import SwiftData

@main
struct SampleAppTVApp: App {
    @StateObject private var router: Router = .init()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(router)
        }
    }
}
