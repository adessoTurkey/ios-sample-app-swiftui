//
//  OnFirstAppearModifier.swift
//  SampleWatchAppSwiftUI
//
//  Created by Yildirim, Alper on 17.10.2023.
//

import SwiftUI

struct OnFirstAppearModifier: ViewModifier {
    let perform: () -> Void
    @State private var firstTime: Bool = true

    func body(content: Content) -> some View {
        content.onAppear {
            if firstTime {
                firstTime = false
                self.perform()
            }
        }
    }
}

extension View {
    func onFirstAppear(perform: @escaping () -> Void) -> some View {
        self.modifier(OnFirstAppearModifier(perform: perform))
    }
}