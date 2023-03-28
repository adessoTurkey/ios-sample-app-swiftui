//
//  HomeFilterView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import SwiftUI

struct HomeFilterView: View {
    var viewModel: HomeViewModel
    var body: some View {
        HStack {
            Text(viewModel.filterTitle)
            Spacer()
            Image(systemName: "slider.horizontal.3")
        }
    }
}

struct HomeFilterView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFilterView(viewModel: .init())
    }
}
