//
//  SearchBarView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 17.03.2023.
//

import PreviewSnapshots
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
                    .accessibilityIdentifier("searchBarViewInputField")
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
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<String> {
        .init(configurations: [
            .init(name: "Empty text", state: ""),
            .init(name: "Short text", state: "Culpa occaecat nostrud."),
            .init(name: "Long text", state: "Non veniam occaecat et ullamco ad aliquip laborum elit ea incididunt id non Lorem deserunt.")
        ]) { state in
            SearchBarView(searchText: .constant(state), topPadding: 0)
        }
    }
}
