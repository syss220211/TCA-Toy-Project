//
//  Target+Template.swift
//  Packages
//
//  Created by 박서연 on 2024/12/12.
//

import ProjectDescription

public extension Target {
    private static let environmentSettings = EnvironmentSettings.default
    private static let organizationName = environmentSettings.organizationName
    private static let destinations = environmentSettings.destinations
    private static let deploymentTargets = environmentSettings.deploymentTargets
    
    static func appTarget(
        name: String,
        dependencies: [Module] = [],
        infoPlist: Bool = true
    ) -> Target {
        let dependencies = dependencies.map { $0.setDependency() }
        
        return Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "com.\(name).\(organizationName)",
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist
            ? .file(path: "Support/info.plist") : .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies,
            settings: Configuration.defaultSettings
        )
    }
}
