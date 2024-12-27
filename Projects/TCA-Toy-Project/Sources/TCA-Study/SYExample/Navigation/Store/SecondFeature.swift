//
//  SecondFeature.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/27/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SecondFeature {
    @ObservableState
    struct State: Equatable {
        var count: Int?
    }
    
    enum Action: Equatable {
        case backToFirstView
        case goToThirdView
        case incrementCount
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backToFirstView:
                return .none
                
            case .goToThirdView:
                return .none
                
            case .incrementCount:
                // count 값이 nil이면 1로 초기화하고, nil이 아니면 증가시킴
                if let currentCount = state.count {
                    state.count = currentCount + 1
                } else {
                    state.count = 1
                }
                return .none
            }
        }
    }
}
