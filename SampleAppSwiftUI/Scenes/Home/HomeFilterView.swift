//
//  HomeFilterView.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 28.03.2023.
//

import PreviewSnapshots
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
        snapshots.previews
    }

    static var snapshots: PreviewSnapshots<String> {
        .init(configurations: [
            .init(name: "Empty text", state: .empty),
            .init(name: "Short text", state: "cupidatat"),
            .init(name: "Long text", state: "Ad tempor cupidatat culpa aliqua amet consectetur velit dolor do est amet.")
        ]) { state in
            HomeFilterView(filterTitle: state)
                .padding(.horizontal)
        }
    }
}
