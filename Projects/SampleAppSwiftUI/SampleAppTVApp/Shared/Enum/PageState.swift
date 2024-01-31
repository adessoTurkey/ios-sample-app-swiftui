//
//  PageState.swift
//  SampleAppTVApp
//
//  Created by Yildirim, Alper on 28.12.2023.
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
                "No data"
            case .loading:
                "Loading"
            case .finished:
                "Finished"
            case .error:
                "An error occured"
            default:
                ""
        }
    }
}
