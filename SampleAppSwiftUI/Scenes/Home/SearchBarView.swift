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
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.searchbarBackground)
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.searchIcon)
                TextField("Search for a name or symbol", text: $searchText)
                    .font(.system(size: 15))
            }
            .padding(.all)
        }
        .frame(height: 56)
        .cornerRadius(18)
        .padding([.trailing, .leading], 16)
        .shadow(color: .black.opacity(0.05), radius: 3, y: 10)
        .padding(.top, topPadding)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), topPadding: 20)
            .previewLayout(.sizeThatFits)
            .frame(width: .infinity, height: 56)
            .padding([.top, .bottom])
    }
}
