//
//  ContentView.swift
//  SampleWatchAppSwiftUI Watch App
//
//  Created by Yildirim, Alper on 27.09.2023.
//

import SwiftUI

struct ContentView: View {

    @State var number: Double = 0

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("\(number, specifier: "%.1f")")
              .focusable()
              .digitalCrownRotation($number, from: 0.0, through: 12.0)
        }
        .padding()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
