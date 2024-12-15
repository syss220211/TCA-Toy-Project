//
//  AddContactFeature.swift
//  App
//
//  Created by 박서연 on 2024/12/15.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddContactFeature {
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .none
                
            case .saveButtonTapped:
                return .none
                
            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}
