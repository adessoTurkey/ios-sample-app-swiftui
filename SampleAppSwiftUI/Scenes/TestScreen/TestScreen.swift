//
//  TestScreen.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 18.04.2023.
//

import SwiftUI

struct TestScreen: View {
    @StateObject private var viewModel = TestViewModel()
    var useCase: AllCoinUseCaseProtocol = AllCoinUseCase()

    var body: some View {
        VStack {
            CoinView(coinInfo: viewModel.coinInfo ?? .demo, viewModel: .init())
            Button("Send Message") {
                Task {
//                    print(websocket.sendMessage())
//                    print(try await useCase.fetchAllCoin(limit: 20, unitToBeConverted: "USD", page: 1))
                }
            }
            List(viewModel.messages) { message in
                Text(message.name)
            }
        }
    }
}

struct TestScreen_Previews: PreviewProvider {
    static var previews: some View {
        TestScreen()
    }
}
