//
//  RSwiftExampleModel.swift
//  SampleAppSwiftUI
//
//  Created by Sucu, Ege on 2.03.2023.
//

import Foundation

struct RSwiftExampleModel {

    init() {
        showExamples()
    }

    func showExamples() {
        let string = R.string.localizable.helloWorld()
        print(string) // prints `Merhaba`

        let sampleImage = R.image.sample()
        print(sampleImage.hashValue) // prints `-6995841204792947031`
        let demoJSONURL = R.file.sampleDataJson
        print(demoJSONURL.name, demoJSONURL.pathExtension) // prints `sample-data json`
        let demoColor = R.color.color()
        print(demoColor ?? .white) // prints `kCGColorSpaceModelRGB 1 1 1 1`
    }
}
