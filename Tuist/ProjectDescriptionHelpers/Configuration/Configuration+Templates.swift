//
//  Configuration+Templates.swift
//  Packages
//
//  Created by 박서연 on 2024/12/12.
//

@preconcurrency import ProjectDescription

public extension Configuration {
    static func getSetting(name: String) -> Settings {
        return Settings.settings(
            base: ["OTHER_LDFLAGS":["-Objc"]],
            configurations: [
                .debug(
                    name: .debug,
                    xcconfig:  .relativeToManifest("Config/Secrets.xcconfig")
                ),
                .release(
                    name: .release,
                    xcconfig: .relativeToManifest("Config/Secrets.xcconfig")
                )
            ])
    }
    
    static let defaultSettings: Settings = Settings.settings(
        base:["OTHER_LDFLAGS":["-Objc"]],
        configurations: [
        .debug(name: .debug, xcconfig: .relativeToManifest("Config/Secrets.xcconfig")),
        .release(name: .release, xcconfig: .relativeToManifest("Config/Secrets.xcconfig"))
        ],
        defaultSettings: .recommended
    )
    
    static let noneSettings = Settings.settings(
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ],
        defaultSettings: .recommended
    )
}


