import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.createAppProject(
    name: "SampleAppSwiftUI",
    projectPackages: [
        Package.remote(url: "https://github.com/CocoaLumberjack/CocoaLumberjack", requirement: .upToNextMajor(from: "3.8.0")),
        Package.remote(url: "https://github.com/kean/Pulse", requirement: .upToNextMajor(from: "3.0.0")),
        Package.remote(url: "https://github.com/apple/swift-log.git", requirement: .upToNextMajor(from: "1.5.2")),
        Package.local(path: .relativeToRoot("Projects/NetworkService"))
    ],
    projectSettings: .projectSettings,
    destinations: [.iPhone, .iPad, .macWithiPadDesign],
    deploymentTargets: .iOS("16.0"),
    appTargetScripts: [
        .pre(path: .relativeToRoot("scripts/installation/swiftlint.sh"), name: "SwiftLint", basedOnDependencyAnalysis: false)
    ],
    appTargetSettings: .targetSettings,
    dependencies: [
        .package(product: "CocoaLumberjack"),
        .package(product: "CocoaLumberjackSwift"),
        .package(product: "CocoaLumberjackSwiftLogBackend"),
        .package(product: "PulseUI"),
        .package(product: "NetworkService")
    ],
    hasUnitTestTarget: true,
    hasUITestTarget: true
)
