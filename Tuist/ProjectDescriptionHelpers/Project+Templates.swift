import Foundation
import ProjectDescription

extension Project {

    static func generateBundleId(for target: String) -> String {
        "com.adesso.\(target)"
    }

    public static func createAppModule(
        name: String,
        projectPackages: [Package] = [],
        projectSettings: Settings?,
        destinations: Destinations,
        deploymentTargets: DeploymentTargets?,
        appTargetScripts: [TargetScript] = [],
        appTargetSettings: Settings?,
        dependencies: [TargetDependency] = [],
        hasUnitTestTarget: Bool,
        hasUITestTarget: Bool
    ) -> Project {
        var targets: [Target] = []

        let appTarget = Target(
            name: name,
            destinations: destinations,
            product: .app,
            productName: name,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)",
            deploymentTargets: deploymentTargets,
            infoPlist: .file(path: .relativeToRoot("Modules/\(name)/\(name)/Info.plist")),
            sources: SourceFilesList.paths([.relativeToRoot("Modules/\(name)/\(name)/**")]),
            resources: ResourceFileElements(
                resources: [
                    ResourceFileElement.glob(pattern: .relativeToRoot("Modules/\(name)/\(name)/Resources/**"))
                ]
            ),
            scripts: appTargetScripts,
            dependencies: dependencies,
            settings: appTargetSettings
        )

        targets.append(appTarget)

        if hasUnitTestTarget {
            let unitTestTargetName = "\(name)Tests"
            let unitTestTarget = Target(
                name: unitTestTargetName,
                destinations: destinations,
                product: .unitTests,
                productName: unitTestTargetName,
                bundleId: generateBundleId(for: unitTestTargetName),
                deploymentTargets: deploymentTargets,
                infoPlist: .file(path: .relativeToRoot("Modules/\(name)/\(unitTestTargetName)/Info.plist")),
                sources: SourceFilesList.paths([.relativeToRoot("Modules/\(name)/\(unitTestTargetName)/**")]),
                dependencies: dependencies
            )

            targets.append(unitTestTarget)
        }
        
        if hasUITestTarget {
            let uiTestTargetName = "\(name)UITests"
            let uiTestTarget = Target(
                name: uiTestTargetName,
                destinations: destinations,
                product: .uiTests,
                productName: uiTestTargetName,
                bundleId: generateBundleId(for: uiTestTargetName),
                deploymentTargets: deploymentTargets,
                infoPlist: .file(path: .relativeToRoot("Modules/\(name)/\(uiTestTargetName)/Info.plist")),
                sources: SourceFilesList.paths([.relativeToRoot("Modules/\(name)/\(uiTestTargetName)/**")])
            )

            targets.append(uiTestTarget)
        }

        return Project(
            name: name,
            options: .options(
                automaticSchemesOptions: .disabled,
                disableBundleAccessors: true,
                disableSynthesizedResourceAccessors: true
            ),
            packages: projectPackages,
            settings: projectSettings,
            targets: targets,
            schemes: [Scheme.createScheme(for: name, executable: name, hasUnitTestTarget: hasUnitTestTarget, hasUITestTarget: hasUITestTarget)]
            // schemes: Scheme.allSchemes(for: name, hasUnitTestTarget: hasUnitTestTarget, hasUITestTarget: hasUITestTarget) // MARK: If you want to create separate scheme for all BuildEnvironment use this method
        )
    }
}
