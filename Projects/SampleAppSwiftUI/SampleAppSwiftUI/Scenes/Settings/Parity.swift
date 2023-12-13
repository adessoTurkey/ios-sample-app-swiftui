//
//  Parity.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 29.03.2023.
//

import Foundation

enum Parity: String, CaseIterable, Identifiable {
    case USD, ETH, AVAX

    var id: Self { self }
}
