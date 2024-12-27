//
//  FirstFeatuer.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/27/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FirstFeature {
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case goToSecondView
        case backToRoot
        case back
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .goToSecondView:
                return .none
                
            case .backToRoot:
                return .none
                
            case .back:
                return .none
            }
        }
    }
}