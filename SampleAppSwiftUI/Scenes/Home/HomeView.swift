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
    @State private var filterTitle = "Most Popular"

    var body: some View {
        NavigationView {
            VStack {
                filterView
                NavigationLink("Click Here", destination: CoinDetailView())
            }
        }
        .background(Color.lightGray)
        .ignoresSafeArea(.all, edges: [.top, .trailing, .leading])
    }

    var filterView: some View {
        HStack {
            Text(filterTitle)
            Spacer()
            Image(systemName: "")
        }
        .task {
            viewModel.startSocketConnection()
        }
    }

//    @ViewBuilder
//    func coinInfo() -> some View {
//        if let coin = viewModel.coinInfo {
//            Text(coin.coinName())
//                .foregroundColor(.white)
//                .bold()
//            Text(coin.formattedPrice())
//                .foregroundColor(.white)
//                .bold()
//        }
//    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
