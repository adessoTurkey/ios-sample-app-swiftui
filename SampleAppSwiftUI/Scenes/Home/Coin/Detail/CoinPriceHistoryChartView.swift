//
//  CoinPriceHistoryChartView.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 31.05.2023.
//

import SwiftUI
import Charts

struct CoinPriceHistoryChartView: View {
    @StateObject private var viewModel: CoinPriceHistoryChartViewModel

    init(selectedRange: CoinChartHistoryRange, dataModel: CoinPriceHistoryChartDataModel, selectedXDateText: String) {
        _viewModel = StateObject(
            wrappedValue: CoinPriceHistoryChartViewModel(
                selectedRange: selectedRange,
                dataModel: dataModel,
                selectedXDateText: selectedXDateText
            )
        )
    }

    var body: some View {
        chart
            .chartPlotStyle { plotContent in
                plotContent
                    .border(Color(uiColor: .systemGray4), width: 1)
            }
            .chartXScale(domain: viewModel.chartXScaleDomain)
            .chartYScale(domain: viewModel.chartYScaleDomain)
            .chartPlotStyle { chartPlotStyle($0) }
            .chartOverlay { proxy in
                GeometryReader { geometryProxy in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged {
                                    viewModel.onChangeDrag(value: $0, chartProxy: proxy, geometryProxy: geometryProxy)
                                }
                                .onEnded { _ in
                                    viewModel.onEndDrag()
                                }
                        )
                }
            }
            .chartXAxis {
                AxisMarks(
                    values: AxisMarkValues.stride(
                        by: viewModel.selectedRange.xAxisFormatter.strideCalendarComponent,
                        count: viewModel.selectedRange.xAxisFormatter.strideCount
                    )
                ) {
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                        .foregroundStyle(Color(uiColor: .systemGray4))
                    AxisTick(stroke: StrokeStyle(lineWidth: 0.5))
                        .foregroundStyle(Color(uiColor: .systemGray4))
                    AxisValueLabel(format: viewModel.selectedRange.xAxisFormatter.valueLabelDateFormatStyle)
                }
            }
            .chartYAxis {
                AxisMarks { value in
                    if let price = value.as(Double.self) {
                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                            .foregroundStyle(Color(uiColor: .systemGray4))
                        AxisTick(stroke: StrokeStyle(lineWidth: 0.5))
                            .foregroundStyle(Color(uiColor: .systemGray4))
                        AxisValueLabel {
                            Text(verbatim: viewModel.format(price: price))
                        }
                    } else {
                        AxisGridLine()
                    }
                }
            }
    }

    private var chart: some View {
        Chart(viewModel.dataModel.prices) {
            LineMark(
                x: .value("Date", $0.date),
                y: .value("Average", $0.average)
            )
            .foregroundStyle(viewModel.foregroundMarkColor)

            AreaMark(
                x: .value("Date", $0.date),
                yStart: .value("Low", viewModel.chartYScaleDomain.lowerBound),
                yEnd: .value("Average", $0.average)
            )
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [viewModel.foregroundMarkColor, .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .opacity(0.5)

            if let (selectedX, text) = viewModel.selectedXRuleMark {
                RuleMark(x: .value("Selected date", selectedX))
                    .lineStyle(.init(lineWidth: 1))
                    .annotation {
                        Text(text)
                            .font(.system(size: 12))
                            .foregroundColor(viewModel.foregroundMarkColor)
                    }
                    .foregroundStyle(viewModel.foregroundMarkColor)
            }
        }
        .padding()
    }

    private func chartPlotStyle(_ plotContent: ChartPlotContent) -> some View {
        plotContent
            .frame(height: 250)
            .overlay {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.5))
                    .mask {
                        ZStack {
                            VStack {
                                Rectangle().frame(height: 0.5)
                                Spacer()
                                Rectangle().frame(height: 0.5)
                            }

                            HStack {
                                Rectangle().frame(width: 0.5)
                                Spacer()
                                Rectangle().frame(width: 1)
                            }
                        }
                    }
            }
    }
}

#Preview {
    Group {
        Group {
            ForEach(CoinChartHistoryRange.allCases) { item in
                CoinPriceHistoryChartView(
                    selectedRange: item,
                    dataModel: .demo,
                    selectedXDateText: ""
                )
            }
        }
        Group {
            ForEach(CoinChartHistoryRange.allCases) { item in
                CoinPriceHistoryChartView(
                    selectedRange: item,
                    dataModel: .demo,
                    selectedXDateText: ""
                )
            }
        }
        .preferredColorScheme(.dark)
    }
}
