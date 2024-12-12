//
//  Environment.swift
//  Packages
//
//  Created by 박서연 on 2024/12/12.
//

import ProjectDescription

public struct EnvironmentSettings {
    public let name: String
    public let organizationName: String
    public let deploymentTargets: DeploymentTargets
    public let platform: Platform
    public let destinations: Destinations
    
    public static let `default` = EnvironmentSettings(
        name: "App",
        organizationName: "yapp25-toy-project",
        deploymentTargets: .iOS("16.0"),
        platform: .iOS,
        destinations: [.iPhone]
    )
}

