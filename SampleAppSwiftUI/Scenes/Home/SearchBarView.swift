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
            RoundedRectangle(cornerRadius: Dimensions.CornerRadius.default)
                .fill(Color.searchbarBackground)
            HStack(spacing: Spacings.default) {
                Image(systemName: Images.search)
                    .foregroundColor(.searchIcon)
                TextField("Search for a name or symbol", text: $searchText)
                    .font(Fonts.searchBar)
            }
            .padding(.all)
        }
        .frame(height: Dimensions.searchBarHeight)
        .cornerRadius(Dimensions.CornerRadius.default)
        .lightShadow(color: .shadowColor)
        .padding(.top, topPadding)
        .padding(.bottom, Paddings.SearchBar.bottom)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), topPadding: Paddings.SearchBar.shortTop)
            .previewLayout(.sizeThatFits)
            .frame(width: .infinity, height: Dimensions.searchBarHeight)
            .padding(.vertical)
    }
}
