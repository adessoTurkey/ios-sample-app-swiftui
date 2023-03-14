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

    @StateObject private var viewModel = HomeViewModel()
    @State private var showPulseUI = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                Color.red
                coinInfo
            }

            Button {
                showPulseUI.toggle()
            } label: {
                Text("Pulse")
                    .foregroundColor(.black)
            }
            .padding(.all)
            .background(Color.white)
            .cornerRadius(20)
            .offset(x: 0, y: -30)

        }
        .task {
            viewModel.startSocketConnection()
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

    var coinInfo: some View {
        VStack {
            if let coin = viewModel.coinInfo {
                Text(coin.coinName())
                    .foregroundColor(.white)
                    .bold()
                Text(coin.formattedPrice())
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
