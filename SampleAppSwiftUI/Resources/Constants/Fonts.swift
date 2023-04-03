//
//  Fonts.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 3.04.2023.
//

import SwiftUI

struct Fonts {
    struct Size {
        static let coinInfo: CGFloat = 17
        static let searchBar: CGFloat = 15
    }

    static let coin: Font = .system(size: Size.coinInfo)
    static let searchBar: Font = .system(size: Size.searchBar)
}
