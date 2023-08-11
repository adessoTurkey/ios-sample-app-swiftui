//
//  HomeFilterView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import SwiftUI

struct HomeFilterView: View {
    var filterTitle: String
    var body: some View {
        HStack {
            Text(filterTitle)
            Spacer()
            Image(systemName: Images.filter)
        }
    }
}

struct HomeFilterView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFilterView(filterTitle: "")
    }
}