//
//  ImageFrameModifier.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 31.03.2023.
//

import SwiftUI

struct ImageFrameModifier: ViewModifier {

    var width: CGFloat?
    var height: CGFloat?

    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
    }
}

extension View {
    func imageFrame(width: CGFloat? = Numbers.imageWidth, height: CGFloat? = Numbers.imageHeight) -> some View {
        modifier(ImageFrameModifier(width: width, height: height))
    }
}
