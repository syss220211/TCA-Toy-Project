// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [:],
        baseSettings: .settings(
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ]
        )
    )
#endif

let package = Package(
    name: "TCAToyProject",
    dependencies: [
//        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.14.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.3.9"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.12.1"),
        .package(url: "https://github.com/airbnb/lottie-ios", from: "4.5.0")
    ]
)
