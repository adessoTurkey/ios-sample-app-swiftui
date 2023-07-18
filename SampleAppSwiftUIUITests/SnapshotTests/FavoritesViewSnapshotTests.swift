//
//  HomeViewSnapshotTests.swift
//  SampleAppSwiftUIUITests
//
//  Created by Yildirim, Alper on 17.07.2023.
//

@testable import SampleAppSwiftUI
import PreviewSnapshotsTesting
import SwiftUI
import XCTest

class CoinViewSnapshotTests: XCTestCase {

    func testSnapshots() {
        CoinView_Previews.snapshots.assertSnapshots(
            as: .image(layout: .sizeThatFits))
    }
}
