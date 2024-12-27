//
//  StudyRootFeature.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/27/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct StudyRootFeature {
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
        // 하위 enum 타입의 Path를 바라보게함
    }
    
    enum Action {
        case clickFirst
        case clickSecond
        case clickThird
        case clickFourth
        case goToBack(id: StackElementID)
        case path(StackActionOf<Path>)
        case popToRoot
        case navigateToScreen(Path.State)
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .clickFirst:
                state.path.append(.firstFeature(FirstFeature.State()))
                return .none
                
            case .clickSecond:
                state.path.append(.secondFeature(SecondFeature.State()))
                return .none
                
            case .clickThird:
                state.path.append(.thirdFeature(ThirdFeature.State()))
                return .none
                
            case .clickFourth:
                state.path.append(.fourthFeature(FourthFeature.State()))
                return .none
                
            case .goToBack(let id):
                state.path.pop(to: id)
                return .none

            case let .path(action):
                switch action {
                case .element(id: _, action: .firstFeature(.goToSecondView)):
                    state.path.append(.secondFeature(SecondFeature.State()))
                    return .none
                    
                case .element(id: _, action: .firstFeature(.backToRoot)):
                    return .send(.popToRoot)
                    
                case .element(id: _, action: .secondFeature(.goToThirdView)):
                    state.path.append(.thirdFeature(ThirdFeature.State()))
                    return .none
                                        
                case .element(id: _, action: .thirdFeature(.goToFourthView)):
                    state.path.append(.fourthFeature(FourthFeature.State()))
                    return .none
                    
                case .element(id: _, action: .secondFeature(.backToFirstView)):
                    state.path.removeLast()
                    return .none
                    
                case .element(id: _, action: .thirdFeature(.backToSecondView)):
                    state.path.removeLast()
                    return .none
                    
                case .element(id: _, action: .fourthFeature(.backToThirdView)):
                    state.path.removeLast()
                    return .none
                
                case .element(id: _, action: .fourthFeature(.goToSecondView)):
                    handleNavigation(state: &state, target: .secondFeature(SecondFeature.State()))
                    return .none

                case .element(id: _, action: .fourthFeature(.popToFirstView)):
                    handleNavigation(state: &state, target: .firstFeature(FirstFeature.State()))
                    return .none

//                case .element(id: _, action: .fourthFeature(.goToSecondView)):
//                    if let secondFeatureIndex = state.path.firstIndex(where: {
//                        if case .secondFeature = $0 { return true }
//                        return false
//                    }) {
//                        state.path.removeSubrange(secondFeatureIndex+1..<state.path.count)
//                    } else {
//                        state.path.append(.secondFeature(SecondFeature.State()))
//                    }
//                    return .none
//                    
//                case .element(id: _, action: .fourthFeature(.popToFirstView)):
//                    if let firstFeatureIndex = state.path.firstIndex(where: {
//                        if case .firstFeature = $0 { return true }
//                        return false
//                    }) {
//                        state.path.removeSubrange(firstFeatureIndex+1..<state.path.count)
//                    } else {
//                        state.path.append(.firstFeature(FirstFeature.State()))
//                    }
//                    return .none
                    
                case .element(id: _, action: .firstFeature(.back)):
                    state.path.removeLast()
                    return .none
                    
                default:
                    return .none
                }
                
            case .popToRoot:
                state.path.removeAll()
                return .none
                
            case .navigateToScreen(let screen):
                state.path.append(screen)
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case firstFeature(FirstFeature)
        case secondFeature(SecondFeature)
        case thirdFeature(ThirdFeature)
        case fourthFeature(FourthFeature)
    }
    
    private func handleNavigation(state: inout State, target: Path.State) {
        if let targetIndex = state.path.firstIndex(where: { $0 == target }) {
            state.path.removeSubrange(targetIndex + 1..<state.path.count)
        } else {
            state.path.append(target)
        }
    }
}
