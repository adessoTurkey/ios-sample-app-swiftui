//
//  CoinCardView.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 29.12.2023.
//

import Foundation
import SwiftUI

struct CoinCardView: View {
    @EnvironmentObject private var router: Router

    @FocusState var isFocused
    var coin: CoinUIModel

    var body: some View {
        Button(
            action: {
                router.navigate(to: .coinDetail(coin: coin))
            },
            label: {
                VStack {
                    HStack {
                        Text(coin.coinInfo?.code ?? "")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundColor(isFocused ? .white : .gray)

                        Text(coin.detail?.usd?.createPercentageText() ?? "")
                            .font(.subheadline)
                            .foregroundColor(coin.detail?.usd?.createForegroundColor())

                        Spacer()
                    }

                    Spacer()

                    HStack(alignment: .bottom) {
                        Text(coin.detail?.usd?.createPriceString() ?? "")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundColor(isFocused ? .white : .gray)

                        Spacer()

                        CoinLogoView(code: coin.coinInfo?.code)
                    }
                }
                .padding(.all, 16)
            }
        )
        .buttonStyle(.card)
        .padding(.leading, 20)
        .padding(.vertical, 50)
        .frame(width: 400, height: 300)
        .focused($isFocused)
        .animation(.easeOut(duration: isFocused ? 0.12 : 0.35), value: isFocused)
    }
}

struct CoinLogoView: View {
    var code: String?

    var body: some View {
        AsyncImage(url: getLogoURL()) { image in
            image
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "circle.badge.exclamationmark.fill")
        }
    }

    func getLogoURL() -> URL? {
        URLs.Icons.getURL(from: code ?? "")
    }
}

#Preview {
    CoinCardView(coin: .demo)
}
