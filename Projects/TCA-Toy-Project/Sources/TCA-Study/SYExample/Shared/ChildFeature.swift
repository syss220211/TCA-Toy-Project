//
//  ChildFeature.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/26/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ChildFeature {
    @ObservableState
    struct State {
        @Shared var sharedCounter: Int
    }
    
    enum Action {
        case displayCounter
        case incrementCounter
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .displayCounter:
                print("Current Counter!!! \(state.sharedCounter)")
                return .none
                
            case .incrementCounter:
                return .none
            }
        }
    }
}
