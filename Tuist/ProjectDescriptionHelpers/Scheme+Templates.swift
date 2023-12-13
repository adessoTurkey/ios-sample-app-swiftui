import Foundation
import ProjectDescription

extension Scheme {

    /// Creates single scheme for "SampleAppSwiftUI" target with different configuration combination..
    public static func createSchemeForMainApp() -> Scheme {
        let target = "SampleAppSwiftUI"

        let mainTarget = TargetReference(stringLiteral: target)
        let unitTestTarget = TestableTarget(stringLiteral: "\(target)Tests")
        let uiTestTarget = TestableTarget(stringLiteral: "\(target)UITests")
        let executableTarget = TargetReference(stringLiteral: target)

        return .scheme(
            name: target,
            shared: true,
            hidden: false,
            buildAction: .buildAction(
                targets: [
                    mainTarget
                ]
            ),
            testAction: .targets([unitTestTarget, uiTestTarget], configuration: BuildEnvironment.development.configurationName),
            runAction: .runAction(
                configuration: BuildEnvironment.development.configurationName,
                executable: executableTarget
            ),
            archiveAction: .archiveAction(configuration: BuildEnvironment.appStore.configurationName),
            profileAction: .profileAction(
                configuration: BuildEnvironment.appStore.configurationName,
                executable: executableTarget
            ),
            analyzeAction: .analyzeAction(configuration: BuildEnvironment.development.configurationName)
        )
    }

    /// Creates separate schemes for all BuildEnvironments with given target name.
    public static func allSchemes(for target: String, executable: String? = nil, hasUnitTestTarget: Bool, hasUITestTarget: Bool) -> [Scheme] {
        BuildEnvironment.allCases.map({ createScheme(for: $0, target: target, hasUnitTestTarget: hasUnitTestTarget, hasUITestTarget: hasUITestTarget) })
    }

    /// Creates a scheme for given BuildEnvironment with given target name.
    public static func createScheme(for env: BuildEnvironment, target: String, executable: String? = nil, hasUnitTestTarget: Bool, hasUITestTarget: Bool) -> Scheme {
        let config = env.configurationName

        let mainTarget = TargetReference(stringLiteral: target)
        let unitTestTarget: TestableTarget? = hasUnitTestTarget ? TestableTarget(stringLiteral: "\(target)Tests") : nil
        let uiTestTarget: TestableTarget? = hasUITestTarget ? TestableTarget(stringLiteral: "\(target)UITests") : nil
        let testableTargets: [TestableTarget] = [unitTestTarget, uiTestTarget].compactMap({ $0 })
        var executableTarget: TargetReference?
        if let executable {
            executableTarget = "\(executable)"
        }

        return .scheme(
            name: "\(target)-\(env.name)",
            shared: true,
            hidden: false,
            buildAction: .buildAction(
                targets: [
                    mainTarget
                ]
            ),
            testAction: !testableTargets.isEmpty ? .targets(testableTargets, configuration: config) : nil,
            runAction: .runAction(
                configuration: config,
                executable: executableTarget
            ),
            archiveAction: .archiveAction(configuration: config),
            profileAction: .profileAction(
                configuration: config,
                executable: executableTarget
            ),
            analyzeAction: .analyzeAction(configuration: config)
        )
    }

    public static func scheme(
        name: String,
        shared: Bool = true,
        hidden: Bool = false,
        buildAction: ProjectDescription.BuildAction? = nil,
        testAction: ProjectDescription.TestAction? = nil,
        runAction: ProjectDescription.RunAction? = nil,
        archiveAction: ProjectDescription.ArchiveAction? = nil,
        profileAction: ProjectDescription.ProfileAction? = nil,
        analyzeAction: ProjectDescription.AnalyzeAction? = nil
    ) -> Scheme {
        Scheme(
            name: name,
            shared: shared,
            hidden: hidden,
            buildAction: buildAction,
            testAction: testAction,
            runAction: runAction,
            archiveAction: archiveAction,
            profileAction: profileAction,
            analyzeAction: analyzeAction
        )
    }
}
