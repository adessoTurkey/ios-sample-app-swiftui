import Foundation
import ProjectDescription

public enum BuildEnvironment: String, CaseIterable {
    case appStore, development, production
    
    public var name: String { rawValue.firstUppercased }

    public var configurationName: ConfigurationName {
        ConfigurationName(stringLiteral: name)
    }

    public var targetConfigPath: Path {
        .relativeToRoot("Modules/SampleAppSwiftUI/SampleAppSwiftUI/Configs/\(name).xcconfig")
    }

    public var targetConfiguration: Configuration {
        switch self {
        case .appStore:
            return .release(name: configurationName, xcconfig: targetConfigPath)
        case .development:
            return .debug(name: configurationName, xcconfig: targetConfigPath)
        case .production:
            return .debug(name: configurationName, xcconfig: targetConfigPath)
        }
    }

    public var projectConfiguration: Configuration {
        switch self {
        case .appStore:
            return .release(name: configurationName)
        case .development:
            return .debug(name: configurationName)
        case .production:
            return .debug(name: configurationName)
        }
    }
}

extension StringProtocol {
    public var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
