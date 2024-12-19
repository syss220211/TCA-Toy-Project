//
//  ProfileFeature.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/19/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import ComposableArchitecture
import Foundation

struct Profile: Identifiable, Equatable {
    let id: UUID
    let name: String
    let isNotificationsEnabled: Bool
}

@Reducer
struct ProfileFeature {
    @ObservableState
    struct State: Equatable {
        var name: String = ""
        var isNotificationsEnabled: Bool = false
        var people: IdentifiedArrayOf<Profile> = []
        var isNameTooLong: Bool = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case saveProfile
        case resetForm
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                state.isNameTooLong = state.name.count > 10
                return .none
                
            case .saveProfile:
                let new = Profile(id: UUID(), name: state.name, isNotificationsEnabled: state.isNotificationsEnabled)
                state.people.append(new)
                // return .none
                
                // 연달아서 resetForm을 실행하고 싶을 때
                return .run { send in
                    await send(.resetForm)
                }
                
                
            case .resetForm:
                state.name = ""
                state.isNotificationsEnabled = false
                return .none
            }
        }
    }
}
