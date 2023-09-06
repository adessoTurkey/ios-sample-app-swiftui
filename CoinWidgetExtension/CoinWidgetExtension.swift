//
//  CoinWidgetExtension.swift
//  CoinWidgetExtension
//
//  Created by Sahin, Meryem on 11.08.2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @AppStorage("favoriteCoins", store: UserDefaults(suiteName: "group.com.adesso.SampleAppSwiftUI")) var favoriteCoins: [CoinData] = []

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(favoriteCoins: favoriteCoins)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(favoriteCoins: favoriteCoins)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [SimpleEntry(favoriteCoins: favoriteCoins)], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date = Date()
    var favoriteCoins: [CoinData]
}

struct CoinWidgetExtensionEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    @ViewBuilder
    var emptyView: some View {
        Text("There are no favorite coins")
    }

    @ViewBuilder
    var coinsView: some View {
        VStack {
            ForEach(entry.favoriteCoins) { val in
                HStack {
                    Text(val.coinInfo?.title ?? "")
                }
            }
        }
    }

    var body: some View {
        switch widgetFamily {
            case .systemSmall:
                entry.favoriteCoins.isEmpty ? AnyView(emptyView) : AnyView(coinsView)
            case .systemMedium:
                entry.favoriteCoins.isEmpty ? AnyView(emptyView) : AnyView(coinsView)
            default:
                Text(entry.date, style: .time)
        }
    }
}

struct CoinWidgetExtension: Widget {
    let kind: String = "CoinWidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CoinWidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct CoinWidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        
        CoinWidgetExtensionEntryView(entry: SimpleEntry(favoriteCoins: [])).previewContext(WidgetPreviewContext(family: .systemSmall))
        CoinWidgetExtensionEntryView(entry: SimpleEntry(favoriteCoins: [])).previewContext(WidgetPreviewContext(family: .systemMedium))

    }
}

extension Array: RawRepresentable where Element: Codable {
public init?(rawValue: String) {
    guard let data = rawValue.data(using: .utf8),
          let result = try? JSONDecoder().decode([Element].self, from: data)
    else {
        return nil
    }
    self = result
}

public var rawValue: String {
    guard let data = try? JSONEncoder().encode(self),
          let result = String(data: data, encoding: .utf8)
    else {
        return "[]"
    }
    return result
    }
}
