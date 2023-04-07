//
//  MockPath.swift
//  SampleAppSwiftUI
//
//  Created by Alver, Tunay on 5.04.2023.
//

import Foundation

enum MockPath {
    case coinList

    var value: String {
        switch self {
            case .coinList:
                return "CoinList"
        }
    }
}
