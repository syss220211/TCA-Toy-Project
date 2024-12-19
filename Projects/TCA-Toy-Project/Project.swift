@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    target: [
        .appTarget(
            name: "TCA-Toy-Project",
            dependencies: [
//                .spm(.Lottie),
                .spm(.ComposableArchitecture)
            ]
        ),
    ]
)
