//
//  TextExtensions.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 24.07.2023.
//

import Foundation
import SwiftUI

extension Text {
    func limitedCharacterCount(_ limit: Int, _ text: String, _ additionalText: String = "") -> Text {
        let text = self.trimmed(text: text)
        if text.count <= limit {
            return self
        } else {
            let trimmedText = String(text.prefix(limit))
            return Text(trimmedText + additionalText)
        }
    }
    private func trimmed(text: String) -> String {
        let text = text
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
