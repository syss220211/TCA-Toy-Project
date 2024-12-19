//
//  Project+Template.swift
//  Packages
//
//  Created by 박서연 on 2024/12/12.
//

@preconcurrency import ProjectDescription

public extension Project {
    nonisolated(unsafe) private static let environmentSettings = EnvironmentSettings.default
    private static let appName = environmentSettings.name
    private static let organizationName = environmentSettings.organizationName
    
    static let customOption: Options = .options(
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko"
    )
    
    static func app(
        target: [Target]
    ) -> Project {
        return Project(
            name: appName,
            organizationName: organizationName,
            options: customOption,
            settings: Configuration.noneSettings,
            targets: target,
            schemes: [
                .scheme(target: .debug, name: appName)
            ]
        )
    }
}

