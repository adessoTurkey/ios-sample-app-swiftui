//
//  HomeView.swift
//  boilerplate-ios-swiftui
//
//  Created by Cagri Gider on 14.08.2022.
//  Copyright © 2022 Adesso Turkey. All rights reserved.
//

import SwiftUI
import PulseUI

struct HomeView: View {

    @State private var showPulseUI = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Click Here", destination: CoinDetailView())
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showPulseUI) {
            NavigationView {
                ConsoleView()
                    .navigationBarItems(leading: Button("Close") {
                        showPulseUI = false
                    })
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
