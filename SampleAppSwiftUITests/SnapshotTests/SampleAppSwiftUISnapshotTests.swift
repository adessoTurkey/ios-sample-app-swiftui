//
//  SampleAppSwiftUISnapshotTests.swift
//  SampleAppSwiftUITests
//
//  Created by Yildirim, Alper on 25.07.2023.
//

@testable import SampleAppSwiftUI
import PreviewSnapshotsTesting
import XCTest

class SampleAppUISnapshotTests: SnapshotTestCase {
    private var deviceConfig: SwiftUISnapshotLayout = .device(config: .iPhone13)

    func test_settingsView_snapshots() throws {
        verifyView(SettingsView_Previews.snapshots, using: deviceConfig)
    }

    func test_mainView_snapshots() throws {
        verifyView(MainView_Previews.snapshots, using: deviceConfig)
    }

    func test_homeView_snapshots() throws {
        verifyView(HomeView_Previews.snapshots, using: deviceConfig)
    }

    func test_favoritesView_snapshots() throws {
        verifyView(FavoritesView_Previews.snapshot, using: deviceConfig)
    }

    func test_homeFilterView_snapshots() throws {
        verifyView(HomeFilterView_Previews.snapshots, using: .fixed(width: 400, height: 100))
    }

    func test_searchBarView_snapshots() throws {
        verifyView(HomeFilterView_Previews.snapshots, using: .fixed(width: 400, height: 100))
    }

    func test_coinView_snapshots() throws {
        verifyView(CoinView_Previews.snapshots, using: .fixed(width: 400, height: 100))
    }

    func test_coin_listView_snapshots() throws {
        verifyView(CoinListView_Previews.snapshots, using: deviceConfig)
    }

    func test_coin_changePercentageView_snapshots() throws {
        verifyView(ChangePercentageView_Previews.snapshots, using: .fixed(width: 120, height: 40))
    }

    func test_coin_chartHistoryRangeButtons_snapshots() throws {
        verifyView(CoinChartHistoryRangeButtons_Previews.snapshots, using: .fixed(width: 500, height: 50))
    }

    func test_coin_detailView_snapshots() throws {
        verifyView(CoinDetailView_Previews.snapshots, using: deviceConfig)
    }

    func test_coin_priceHistoryChartView_snapshots() throws {
        verifyView(CoinPriceHistoryChartView_Previews.snapshots, using: .fixed(width: 500, height: 600))
    }
}
