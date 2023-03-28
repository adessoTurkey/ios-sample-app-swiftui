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
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .tertiarySystemBackground))
            HStack {
                AsyncImage(url: URL(string: "https://cryptoicons.org/api/icon/\(coinInfo.code.lowercased())/200")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    } else if phase.error != nil {
                        VStack {
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .frame(width: 40, height: 40)
                        }
                    } else {
                        ProgressView()
                            .frame(width: 40, height: 40)
                    }
                }
                .scaledToFit()
                .frame(width: 40, height: 40)

                VStack(alignment: .leading, spacing: 8) {
                    Text(coinInfo.code)
                        .font(.system(size: 17))
                        .bold()
                    Text(coinInfo.title)
                        .foregroundColor(Color(uiColor: .systemGray))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 8) {
                    Text(viewModel.createPriceString(coinInfo: coinInfo))
                        .font(.system(size: 17))
                        .bold()
                    Text(viewModel.createChangeText(coinInfo: coinInfo))
                        .foregroundColor(coinInfo.changeAmount < 0 ? .red : .green)
                }
            }
            .padding([.trailing, .leading], 16)
        }
        .alert(isPresented: $showingAlert, content: {
            let text = viewModel.manageFavorites(coinInfo: coinInfo)
            return Alert(title: Text(text), dismissButton: .default(Text("Got it!")))
        })
        .onLongPressGesture(minimumDuration: 1){
            showingAlert = true
        }
        .frame(height: 72)
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinView(coinInfo: .demo)
                .previewLayout(.sizeThatFits)
                .frame(height: 72)
                .padding([.top, .bottom])
            CoinView(coinInfo: .demo)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .frame(height: 72)
                .padding([.top, .bottom])
                .padding([.trailing, .leading], 16)

        }
    }
}
