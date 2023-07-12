[![swift-version](https://img.shields.io/badge/swift-5.8-brightgreen.svg)](https://github.com/apple/swift)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/adessoTurkey/boilerplate-ios-swiftui/iOS%20Build%20Check%20Workflow/develop)

# iOS SwiftUI Sample App

This is the iOS SwiftUI Sample App created by adesso Turkey. The project serves as a comprehensive showcase of the best practices in iOS development by utilizing latest available technology. Other open source 


## Table of Contents

- [Prerequisites](#Prerequisites)
- [Installation](#installation)
- [Brancing Strategy](#branching-strategy)
- [Project Structure](#project-structure)
- [Workspace Preparing](#workspace-preparing)
- [List of Frameworks](#list-of-frameworks)
- [License](#license)

## Prerequisites

- [Swift 5.8](https://developer.apple.com/support/xcode/)
- [MacOS Monterey (12.5 or higher)](https://www.apple.com/by/macos/monterey/features/)
- [Xcode 14 or higher](https://developer.apple.com/documentation/xcode-release-notes/xcode-14-release-notes)
- [Swiftlint][github/swiftlint]
- [SwiftGen](https://github.com/SwiftGen/SwiftGen)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen)

## Installation

Because XcodeGen is used in this project, there will be no `.xcodeproj` or `.xcworkspace` files when it first cloned. To generate them using the `project.yml` file, run

```sh
xcodegen generate
```

Swiftlint and SwiftGen can also be installed via included scripts in the repository. Under the `{project_root}/scripts/installation` directory, simply run either or both of:

```
sh swiftlint.sh
sh swiftgen.sh
```

## Branching Strategy

Gitflow is a legacy Git workflow that was originally a disruptive and novel strategy for managing Git branches. Gitflow has fallen in popularity in favor of trunk-based workflows, which are now considered best practices for modern continuous software development and DevOps practices. Gitflow also can be challenging to use with CI/CD.

| Branch      | Description                                                                                                                                                                                                                                                                             |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Main**    | In the Git flow workflow, the main branch is used to store code that is release-ready and ready for production.                                                                                                                                                                         |
| **Develop** | The develop branch contains pre-production code with recently built features that are currently being tested. It is established at the beginning of a project and maintained during the development process.                                                                            |
| **Feature** | You will create a feature branch off the develop branch while working on a new feature, and once it has been finished and carefully reviewed, you will merge your changes into the develop branch.                                                                                      |
| **Hotfix**  | The hotfix branch is utilized in the Git pipeline to swiftly address required changes in your main branch. Your main branch should serve as the base for the hotfix branch, and it should be merged back into both the main and develop branches.                                       |
| **Release** | The release branch should be used when preparing new production releases. Typically, the work being performed on release branches concerns finishing touches and minor bugs specific to releasing new code, with code that should be addressed separately from the main develop branch. |

- Branch names should start with feature, hotfix or release according to purpose of the branch then should continue with ticket ID. see example: feature/SASU-1234_some-issue
- Pull requests should refer to specific issue with ticketid. see example: [SASU-1234] - New feature
- Merge strategy: Rebase and Merge is preffered for maintaining a linear project history.

## Project Structure

| Name                      | Description                                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Application/Services**/ | Application based services will be defined here, such as logging, network, server...                    |
| **Configs**/              | Everything relative to build and environment configuration will be defined here                         |
| **Managers**/             | Managers will be put here such as LoggerManager, SwifterManager etc.                                    |
| **Network**/              | Network related implementations will be defined here. This will include endpoint builders to use cases. |
| **Scenes**/               | Application related scenes will be defined here, such as routing, UI implementations etc.               |
| **Utility**/              | Utilities includes extensions, final classes and other resources.                                       |
| **Resources**/            | Images, icons, assets, fonts, Mocks, Localization...                                                    |

## Workspace Preparing

### Changing the Project Name

- On the directory of `{project_root}/scripts/installation`, via terminal
  - run `./rename-project.swift "$NEW_PROJECT_NAME"` to change project name.
  - run `sh install-githooks.sh` to install git-hooks into your project. Includes following git hooks; Git hooks include SwiftLint validation, git message character limitation and issue-id check
    - pre-commit: This hook provides swiftlint control to detect errors quickly before commit.
    - commit-msg: This hook checks that messages must have a minimum 50 characters. It also tells it should contain an issue tag. Ticket id must be between square brackets and [ticketid] separated by hyphens. See example: "[ISSUE-123] commit message" or "[JIRA-56] - commit message"

### Encrpytion Choice (Optional)

- If you wish to silence App Store Connect's "Encryption Ask" or don't use any external encryption in your project, you can define `ITSAppUsesNonExemptEncryption` key as `NO` in the Info.plist. [Learn more in here][apple/ITSAppUsesNonExemptEncryption]

## List of Frameworks

| Framework                                                             | Description                                                                         |
| --------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| [SwiftLint][github/swiftlint]                                         | A tool to enforce Swift style and conventions.                                      |
| [Pulse](https://github.com/kean/Pulse)                                | Pulse is a powerful logging system for Apple Platforms. Native. Built with SwiftUI. |
| [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) | Powerful & flexible logging framework.                                              |
| [SwiftLog](https://github.com/apple/swift-log)                        | Logging API for Swift that works well with compatible API's.                        |

## Useful Tools and Resources

- [SwiftLint][github/swiftlint] - A tool to enforce Swift style and conventions.
- [TestFlight](https://help.apple.com/itunes-connect/developer/#/devdc42b26b8) - TestFlight beta testing lets you distribute beta builds of your app to testers and collect feedback.
- [Appcenter](https://appcenter.ms/) - Continuously build, test, release, and monitor apps for every platform.
- [Figma Link](https://www.figma.com/file/RAgvUa7cfDTVteU8Z6Qv1z/SampleAppSwiftUI?node-id=48%3A2425&t=jRUyk0dLzFPejhfL-1)
- [Open Issues](https://github.com/adessoTurkey/ios-sample-app-swiftui/issues)

## Join the crew!

[Act now to join][linkedin/jobs] our team and become an adessi — enjoy a Great Place to Work!

## License

```
Copyright 2023 adesso Turkey

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

[github/swiftlint]: https://github.com/realm/SwiftLint
[linkedin/jobs]: https://www.linkedin.com/company/adessoturkey/jobs/
[apple/ITSAppUsesNonExemptEncryption]: https://developer.apple.com/documentation/bundleresources/information_property_list/itsappusesnonexemptencryption
