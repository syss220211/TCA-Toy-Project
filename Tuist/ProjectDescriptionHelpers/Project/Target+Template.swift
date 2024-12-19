//
//  Target+Template.swift
//  Packages
//
//  Created by 박서연 on 2024/12/12.
//

@preconcurrency import ProjectDescription

public extension Target {
    nonisolated(unsafe) private static let environmentSettings = EnvironmentSettings.default
    private static let organizationName = environmentSettings.organizationName
    private static let destinations = environmentSettings.destinations
    private static let deploymentTargets = environmentSettings.deploymentTargets
    
    static func appTarget(
        name: String,
        dependencies: [Module] = []
    ) -> Target {
        let dependencies = dependencies.map { $0.setDependency() }
        
        return Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "com.\(name).\(organizationName)",
            deploymentTargets: deploymentTargets,
            infoPlist: .file(path: "Support/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies,
            settings: Configuration.defaultSettings
        )
    }
}
