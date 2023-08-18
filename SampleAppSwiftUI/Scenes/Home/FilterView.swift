//
//  HomeFilterView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import SwiftUI

struct FilterView<ViewModel: ViewModelProtocol>: View {
    var viewModel: ViewModel

    @State private var selectedSort: SortOptions = .defaultList

    var body: some View {
        HStack {
            Text(selectedSort.rawValue)
            Spacer()

            Menu {
                ForEach(SortOptions.allCases, id: \.rawValue) { sortOption in
                    Button {
                        selectedSort = sortOption
                    } label: {
                        Text(sortOption.rawValue)
                    }
                }
            } label: {
                Image(systemName: Images.filter)
            }
        }
    }
}

struct HomeFilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: HomeViewModel())
    }
}
