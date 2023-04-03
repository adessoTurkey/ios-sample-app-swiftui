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
            RoundedRectangle(cornerRadius: Dimensions.CornerRadius.standard)
                .fill(Color.coinCellBackground)
            HStack {
                AsyncImage(url: viewModel.getURL(from: coinInfo.code)) { phase in
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

                VStack(alignment: .leading, spacing: Spacings.standard) {
                    Text(coinInfo.code)
                        .font(Fonts.coin)
                        .bold()
                    Text(coinInfo.title)
                        .foregroundColor(Color(uiColor: .systemGray))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: Spacings.standard) {
                    Text(viewModel.createPriceString(coinInfo: coinInfo))
                        .font(Fonts.coin)
                        .bold()
                    Text(viewModel.createChangeText(coinInfo: coinInfo))
                        .foregroundColor(configureTextColor(coinInfo))
                }
            }
            .sidePadding(size: Paddings.side)
        }
        .alert(isPresented: $showingAlert, content: configureAlert)
        .onLongPressGesture(minimumDuration: 1, perform: showAlert)
        .frame(height: Dimensions.coinCellSize)
    }

    func showAlert() {
        showingAlert = true
    }

    func configureAlert() -> Alert {
        let text = viewModel.manageFavorites(coinInfo: coinInfo)
        return Alert(title: Text(text), dismissButton: .default(Text("Got it!")))
    }

    func configureTextColor(_ coinInfo: CoinInfo) -> Color {
        coinInfo.changeAmount < 0 ? .red : .green
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinView(coinInfo: .demo)
            CoinView(coinInfo: .demo)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .frame(height: Dimensions.coinCellSize)
        .topBottomPadding()
        .sidePadding(size: Paddings.side)
    }
}
