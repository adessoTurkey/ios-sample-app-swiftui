import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: "SampleAppTuist",
    projects: [
        Path.relativeToRoot("Modules/SampleAppSwiftUI")
    ]
)
