//
//  Screen.swift
//  SampleAppSwiftUI
//
//  Created by Marifet, Oguz on 11.05.2023.
//

import Foundation

enum ScreenType: String {
    case detail = "1"
}

struct Screen {
    let type: ScreenType
    let data: Any?
}

extension Screen: Identifiable, Hashable {
    var id: ScreenType {
        self.type
    }

    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.type == rhs.type
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}
