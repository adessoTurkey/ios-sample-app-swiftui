//
//  SortOptions.swift
//  SampleAppSwiftUI
//
//  Created by Gedikoglu, Ali on 8.08.2023.
//

import Foundation

public enum SortOptions: String, CaseIterable {
    case mostPopular = "Most Popular"
    case price = "Price (Low- High)"
    case priceReversed = "Price (High-Low)"
    case name = "Name (A-Z)"
    case nameReversed = "Name (Z-A)"
}
