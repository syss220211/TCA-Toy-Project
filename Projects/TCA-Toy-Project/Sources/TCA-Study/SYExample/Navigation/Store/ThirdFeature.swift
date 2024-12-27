//
//  ThirdFeature.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/27/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ThirdFeature {
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case backToSecondView
        case goToFourthView
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backToSecondView:
                return .none
                
            case .goToFourthView:
                return .none
            }
        }
    }
}

