//
//  UIModelProtocol.swift
//  SampleAppSwiftUI
//
//  Created by Abay, Batuhan on 19.12.2023.
//

import Foundation

protocol UIModelProtocol {
    associatedtype ResponseModel

    init(from responseModel: ResponseModel)
    init?(from responseModel: ResponseModel?)
}
