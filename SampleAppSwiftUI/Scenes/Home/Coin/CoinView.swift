//
//  CoinView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 21.03.2023.
//

import SwiftUI

struct CoinView: View {

    var coinInfo: CoinInfo
    @StateObject private var viewModel = CoinInfoViewModel()
    @State private var showingAlert = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Numbers.defaultCornerRadius)
                .fill(Color(uiColor: .tertiarySystemBackground))
            HStack {
                AsyncImage(url: URL(string: "https://cryptoicons.org/api/icon/\(coinInfo.code.lowercased())/40")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .imageFrame()
                    } else if phase.error != nil {
                        VStack {
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .imageFrame()
                        }
                    } else {
                        ProgressView()
                            .imageFrame()
                    }
                }
                .scaledToFit()
                .imageFrame()

                VStack(alignment: .leading, spacing: Numbers.defaultSpacing) {
                    Text(coinInfo.code)
                        .font(.system(size: Numbers.coinInfoFontSize))
                        .bold()
                    Text(coinInfo.title)
                        .foregroundColor(Color(uiColor: .systemGray))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: Numbers.defaultSpacing) {
                    Text(viewModel.createPriceString(coinInfo: coinInfo))
                        .font(.system(size: Numbers.coinInfoFontSize))
                        .bold()
                    Text(viewModel.createChangeText(coinInfo: coinInfo))
                        .foregroundColor(coinInfo.changeAmount < 0 ? .red : .green)
                }
            }
            .padding([.trailing, .leading], Numbers.sidePadding)
        }
        .alert(isPresented: $showingAlert, content: {
            let text = viewModel.manageFavorites(coinInfo: coinInfo)
            return Alert(title: Text(text), dismissButton: .default(Text("Got it!")))
        })
        .onLongPressGesture(minimumDuration: 1) {
            showingAlert = true
        }
        .frame(height: Numbers.coinCellSize)
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinView(coinInfo: .demo)
                .previewLayout(.sizeThatFits)
                .frame(height: Numbers.coinCellSize)
                .padding([.top, .bottom])
            CoinView(coinInfo: .demo)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .frame(height: Numbers.coinCellSize)
                .padding([.top, .bottom])
                .padding([.trailing, .leading], Numbers.sidePadding)

        }
    }
}
