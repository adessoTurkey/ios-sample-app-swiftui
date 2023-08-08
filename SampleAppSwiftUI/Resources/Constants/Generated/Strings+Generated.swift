// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
    /// 5~CCCAGG~%@~%@
    public static func coinPreRequest(_ p1: Any, _ p2: Any) -> String {
        return Strings.tr("Localizable", "CoinPreRequest", String(describing: p1), String(describing: p2), fallback: "5~CCCAGG~%@~%@")
    }
    /// Favorites
    public static let favorites = Strings.tr("Localizable", "Favorites", fallback: "Favorites")
    /// Localizable.strings
    ///   SampleAppSwiftUI
    ///
    ///   Created by Selim Gungorer on 14.09.2022.
    ///   Copyright © 2022 Adesso Turkey. All rights reserved.
    public static let helloWorld = Strings.tr("Localizable", "Hello, World!", fallback: "Hello")
    
    public static let news = Strings.tr("Localizable", "News", fallback: "News")
    
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for: BundleToken.self)
#endif
    }()
}
// swiftlint:enable convenience_type
