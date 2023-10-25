//
//  HomeFilterView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import SwiftUI

struct FilterView<ViewModel: ViewModelProtocol>: View {
    var viewModel: ViewModel

    @State private var sortName = ""

    var body: some View {
        HStack {
            Text(sortName)
            Spacer()

            Menu {
                ForEach(SortOptions.allCases, id: \.rawValue) { sortOption in
                    Button {
                        viewModel.selectedSortOption = sortOption
                        sortName = sortOption.rawValue.localized
                    } label: {
                        Text(sortOption.rawValue.localized)
                    }
                }
            } label: {
                Image(systemName: Images.filter)
            }
        }
        .onAppear {
            sortName = viewModel.selectedSortOption.rawValue.localized
        }
    }
}

struct HomeFilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: HomeViewModel())
    }
}
