//
//  DependencyInformation.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/12/12.
//

import ProjectDescription

public enum Module {
    case spm(SPM)
}

public enum SPM: String {
    case Lottie = "Lottie"
    case ComposableArchitecture = "ComposableArchitecture"
}

extension Module {
    public func setDependency() -> TargetDependency {
        switch self {
        case .spm(let spm):
            return .external(name: spm.rawValue)
        }
    }
}

