//
//  Fonts.swift
//  SampleAppSwiftUI
//
//  Created by Ege Sucu on 3.04.2023.
//

import SwiftUI

enum Fonts {
    enum Size {
        static let coinInfo: CGFloat = 17
        static let coinAmountInfo: CGFloat = 12
        static let searchBar: CGFloat = 15
    }

    static let coin: Font = .system(size: Size.coinInfo)
    static let coinAmount: Font = .system(size: Size.coinAmountInfo)
    static let searchBar: Font = .system(size: Size.searchBar)
}
