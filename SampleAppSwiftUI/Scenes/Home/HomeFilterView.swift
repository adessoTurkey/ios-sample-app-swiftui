//
//  HomeFilterView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import SwiftUI

struct HomeFilterView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        HStack {
            Text(viewModel.selectedSortOption.rawValue)
            Spacer()

            Menu {
                ForEach(HomeViewModel.SortOptions.allCases, id: \.rawValue) { sortOption in
                    Button {
                        viewModel.selectedSortOption = sortOption
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
        HomeFilterView(viewModel: HomeViewModel())
    }
}
