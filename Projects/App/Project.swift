import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    target: [
        .appTarget(
            name: EnvironmentSettings.default.name,
            dependencies: [
                .spm(.Lottie),
//                .spm(.ComposableArchitecture)
            ],
            infoPlist: true
        ),
    ]
)
