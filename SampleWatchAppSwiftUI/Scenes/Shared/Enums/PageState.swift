//
//  PageLoadingState.swift
//  SampleWatchAppSwiftUI
//
//  Created by Yildirim, Alper on 22.10.2023.
//

enum PageState {
    case empty
    case loading
    case idle
    case finished
    case fetching
    case error

    var stateUIString: String {
        switch self {
            case .empty:
                return Strings.noData
            case .loading:
                return "Loading"
            case .finished:
                return "Finished"
            case .error:
                return Strings.noData
            default:
                return ""
        }
    }
}
