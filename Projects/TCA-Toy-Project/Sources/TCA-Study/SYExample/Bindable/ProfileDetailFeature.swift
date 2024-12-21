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
        var selectedPerson: Profile
        var editedName: String
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case updateButtonTapped
        case dismissModal
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case updatePerson(Profile)
//            case dismiss
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.editedName):
                return .none
                
            case .updateButtonTapped:
//                state.selectedPerson.name = state.editedName
//                return .send(.delegate(.updatePerson(state.selectedPerson)))
                state.selectedPerson.name = state.editedName
                return .run { [person = state.selectedPerson] send in
                    await send(.delegate(.updatePerson(person)))
                    await self.dismiss()
                }
                
            case .dismissModal:
//                return .send(.delegate(.dismiss))
                return .run { _ in await self.dismiss() }
                
            case .binding:
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}
