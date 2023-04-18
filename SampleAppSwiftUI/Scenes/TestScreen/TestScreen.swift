//
//  TestScreen.swift
//  SampleAppSwiftUI
//
//  Created by Uslu, Teyhan on 18.04.2023.
//

import SwiftUI

struct TestScreen: View {
    @ObservedObject var websocket = Websocket()
    
    var body: some View {
        VStack {
            Button("Send Message") {
                websocket.sendMessage()
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
