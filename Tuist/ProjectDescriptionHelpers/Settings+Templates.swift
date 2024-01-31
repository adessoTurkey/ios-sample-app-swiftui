import Foundation
import ProjectDescription

extension SettingsDictionary {
    public static let baseSettings: SettingsDictionary = [
        "ENABLE_USER_SCRIPT_SANDBOXING": false,
        "CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED": true,
        "ASSETCATALOG_COMPILER_GENERATE_ASSET_SYMBOLS": true,
        "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": true,
        "LOCALIZATION_PREFERS_STRING_CATALOGS": true,
        "SWIFT_EMIT_LOC_STRINGS": true,
        "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym"
    ]
}

extension ProjectDescription.Settings {
    public static var projectSettings: Self {
        .settings(
            base: .baseSettings,
            configurations: BuildEnvironment.allCases.map(\.projectConfiguration)
        )
    }

    public static var targetSettings: Self {
        .settings(
            configurations: BuildEnvironment.allCases.map(\.targetConfiguration)
        )
    }
}
