//
//  TestScreen.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 18.04.2023.
//

import SwiftUI

struct TestScreen: View {
    @ObservedObject var websocket = Websocket()
    var useCase: AllCoinUseCaseProtocol = AllCoinUseCase()
    
    var body: some View {
        VStack {
            Button("Send Message") {
                
                Task{
                    print(try await useCase.fetchAllCoin())
                }
            }

            List(websocket.messages) { message in
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
