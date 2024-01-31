import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.createAppProject(
    name: "SampleAppSwiftUI",
    projectPackages: [
        Package.remote(url: "https://github.com/CocoaLumberjack/CocoaLumberjack", requirement: .upToNextMajor(from: "3.8.0")),
        Package.remote(url: "https://github.com/kean/Pulse", requirement: .upToNextMajor(from: "3.0.0")),
        Package.remote(url: "https://github.com/apple/swift-log.git", requirement: .upToNextMajor(from: "1.5.2")),
        Package.remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMajor(from: "9.0.0")),
        Package.local(path: .relativeToRoot("Projects/NetworkService"))
    ],
    projectSettings: .projectSettings,
    destinations: [.iPhone, .iPad, .macWithiPadDesign],
    deploymentTargets: .iOS("16.0"),
    appTargetScripts: [
        .pre(path: .relativeToRoot("scripts/installation/swiftlint.sh"), name: "SwiftLint", basedOnDependencyAnalysis: false),
        .post(path: .relativeToRoot("scripts/installation/crashlytics.sh"),
              name: "Crashlytics",
              inputPaths: ["${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}",
                           "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}",
                           "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist",
                           "$(TARGET_BUILD_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist",
                           "$(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)"],
              basedOnDependencyAnalysis: true)
    ],
    appTargetSettings: .targetSettings,
    dependencies: [
        .sdk(name: "AdSupport", type: .framework),
        .package(product: "CocoaLumberjack"),
        .package(product: "CocoaLumberjackSwift"),
        .package(product: "CocoaLumberjackSwiftLogBackend"),
        .package(product: "PulseUI"),
        .package(product: "NetworkService"),
        .package(product: "FirebaseAnalytics"),
        .package(product: "FirebaseCrashlytics"),
        .package(product: "FirebaseMessaging"),
        .package(product: "FirebaseRemoteConfig")
    ],
    hasUnitTestTarget: true,
    hasUITestTarget: true,
    entitlements: .dictionary(["aps-environment": "development"])
)
