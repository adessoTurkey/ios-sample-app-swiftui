//
//  SearchBarView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 17.03.2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var topPadding: CGFloat

    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: Numbers.defaultCornerRadius)
                .fill(Color.searchbarBackground)
            HStack(spacing: Numbers.defaultSpacing) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.searchIcon)
                TextField("Search for a name or symbol", text: $searchText)
                    .font(.system(size: 15))
            }
            .padding(.all)
        }
        .frame(height: Numbers.searchBarHeight)
        .cornerRadius(Numbers.defaultCornerRadius)
        .padding([.trailing, .leading], Numbers.sidePadding)
        .lightShadow(color: .shadowColor)
        .padding(.top, topPadding)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), topPadding: Numbers.searchBarShortTop)
            .previewLayout(.sizeThatFits)
            .frame(width: .infinity, height: Numbers.searchBarHeight)
            .padding([.top, .bottom])
    }
}
