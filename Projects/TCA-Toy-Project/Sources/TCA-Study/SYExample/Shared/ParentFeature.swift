//
//  ParentFeature.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/26/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ParentFeature {
    @ObservableState
    struct State {
        @Shared var sharedCounter: Int
        // 모달을 위한 변수 추가
        @Presents var childFeature: ChildFeature.State?
    }
    
    enum Action {
        case incrementCounter
        case showChildView
        case childFeature(PresentationAction<ChildFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .incrementCounter:
                state.$sharedCounter.withLock { $0 += 1 }
                return .none
                
            case .showChildView:
                state.childFeature = ChildFeature.State(sharedCounter: state.$sharedCounter)
                return .none
                
            case .childFeature(.presented(.incrementCounter)):
                state.$sharedCounter.withLock { $0 += 1 }
                return .none
                
            
            case .childFeature:
                return .none
            }
        }
        .ifLet(\.$childFeature, action: \.childFeature) {
            ChildFeature()
        }
    }
}


