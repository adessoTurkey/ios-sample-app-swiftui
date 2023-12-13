import Foundation
import ProjectDescription

extension Scheme {

    public static func allSchemes(for target: String, executable: String? = nil, hasUnitTestTarget: Bool, hasUITestTarget: Bool) -> [Scheme] {
        BuildEnvironment.allCases.map({ createScheme(for: $0, target: target, hasUnitTestTarget: hasUnitTestTarget, hasUITestTarget: hasUITestTarget) })
    }

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
