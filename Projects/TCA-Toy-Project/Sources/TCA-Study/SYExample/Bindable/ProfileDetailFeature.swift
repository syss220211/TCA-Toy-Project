//
//  ProfileDetailFeature.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/19/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import ComposableArchitecture

@Reducer
struct ProfileDetailFeature {
    @ObservableState
    struct State: Equatable {
        var selectedPerson: Profile? = nil
        var isModalPresented: Bool = false
//        var name: String = ""
    }
    
    enum Action: Equatable {
        case dismissModal//(String)
//        case setName(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismissModal:
                return .none
                
//            case .setName(let value):
//                state.name = value
//                return .none
            }
        }
    }
}
