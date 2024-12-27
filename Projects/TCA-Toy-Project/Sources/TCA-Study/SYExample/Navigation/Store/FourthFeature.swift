//
//  FourthFeature.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/27/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FourthFeature {
    @ObservableState
    struct State: Equatable {
    
    }
    
    enum Action: Equatable {
        case backToThirdView
        case goToSecondView
        case popToFirstView
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backToThirdView:
                return .none
                
            case .goToSecondView:
                return .none
                
            case .popToFirstView:
                return .none
            }
        }
    }
}
