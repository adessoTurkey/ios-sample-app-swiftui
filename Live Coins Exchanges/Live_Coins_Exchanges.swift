//
//  Live_Coins_Exchanges.swift
//  Live Coins Exchanges
//
//  Created by Uslu, Teyhan on 3.08.2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    let favCoins = StorageManager.shared.favoriteCoins
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), coinData: CoinData.demo)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, coinData: favCoins.first ?? CoinData.demo)
        completion(entry)
            }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let entry = SimpleEntry(date: Date(), configuration: configuration, coinData: favCoins.first ?? CoinData.demo)
        var entries: [SimpleEntry] = [entry]

//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration, coinData: CoinData.demo)
//            entries.append(entry)
//        }

//        let timeline = Timeline(entries: entries, policy: .atEnd)
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let coinData: CoinData
}

struct Live_Coins_ExchangesEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        CoinView(coinInfo: entry.coinData)
    }
}
//
//struct Live_Coins_Exchanges: Widget {
//    let kind: String = "Live_Coins_Exchanges"
//
//    var body: some WidgetConfiguration {
//        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
//            Live_Coins_ExchangesEntryView(entry: entry)
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//    }
//}
//
//struct Live_Coins_Exchanges_Previews: PreviewProvider {
//    static var previews: some View {
//        Live_Coins_ExchangesEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), coinData: CoinData.demo))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
