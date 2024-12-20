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
        case detailPersonAction(PresentationAction<ProfileDetailFeature.Action>)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.name):
                if state.name.count > 5 {
                    state.isNameTooLong = true
                } else {
                    state.isNameTooLong = false
                }
                if !state.people.isEmpty {
                    state.people[0].name = state.name
                }
                return .none
                //                return .send(.saveProfile)ㅑ
                
            case .binding:
                return .none
                
            case .saveProfile:
                let new = Profile(id: UUID(), name: state.name, isNotificationsEnabled: state.isNotificationsEnabled)
                state.people.append(new)
//                return .run { [isBool = state.isNameTooLong] send in
//                    await send(abcd(isBool: isBool))
//                }
                return .run { send in
                    await send(.resetForm)
                }
                
            case .resetForm:
                state.name = ""
                state.isNotificationsEnabled = false
                return .none
                
            case .tappedPerson(let person):
                state.detailPerson = ProfileDetailFeature.State(selectedPerson: person, isModalPresented: true)
                return .none
                
//            case .detailPersonAction(.presented(.dismissModal)):
//                state.detailPerson = nil
//                return .none
            case .detailPersonAction(let presentationAction):
                switch presentationAction {
                case .presented(let detailAction):
                    switch detailAction {
                    case .dismissModal(let name):
                        state.name = name
                        state.detailPerson = nil
                        return .none
                    default:
                        // state.detailPerson = nil
                        return .none
                    }
                case .dismiss:
                    state.detailPerson = nil
                    print("Dddddddddd")
                    return .none
                }
            }
        }
        .ifLet(\.$detailPerson, action: \.detailPersonAction) {
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
