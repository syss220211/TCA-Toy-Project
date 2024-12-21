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
    var name: String
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
        @Presents var detailPerson: ProfileDetailFeature.State?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case saveProfile
        case resetForm
        case tappedPerson(Profile)
        case detailPerson(PresentationAction<ProfileDetailFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.name):
                state.isNameTooLong = state.name.count > 10
                return .none
                
            case .binding:
                return .none
                
            case .saveProfile:
                let new = Profile(id: UUID(), name: state.name, isNotificationsEnabled: state.isNotificationsEnabled)
                state.people.append(new)
                return .send(.resetForm)
                
            case .resetForm:
                state.name = ""
                state.isNotificationsEnabled = false
                return .none
                
            case .tappedPerson(let person):
                state.detailPerson = ProfileDetailFeature.State(selectedPerson: person, editedName: person.name)
                return .none
                
            case .detailPerson(.presented(.delegate(.updatePerson(let updatedPerson)))):
                if let index = state.people.index(id: updatedPerson.id) {
                    state.people[index] = updatedPerson
                }
                state.detailPerson = nil
                return .none

            case .detailPerson(.presented(.delegate(.dismiss))):
                state.detailPerson = nil
                return .none
                
            case .detailPerson:
                if state.detailPerson != nil {
                    return .none
                } else {
                    return .none
                }
            }
        }
        .ifLet(\.$detailPerson, action: \.detailPerson) {
            ProfileDetailFeature()
        }
    }
}

private extension ProfileFeature {
    func abcd(isBool: Bool) async -> Action {
        try? await Task.sleep(for: .seconds(2))
        return .saveProfile
    }
}
