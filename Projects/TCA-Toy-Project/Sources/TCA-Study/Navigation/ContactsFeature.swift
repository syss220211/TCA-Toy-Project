//
//  ContactsFeature.swift
//  App
//
//  Created by 박서연 on 2024/12/15.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    @ObservableState
    struct State {
        @Presents var addContact: AddContactFeature.State?
        @Presents var alert: AlertState<Action.Alert>? // Alert
        var contacts: Array<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
        // 삭제 action 추가
        case deleteButtonTapped(id: Contact.ID) // 삭제 버튼 (trash)를 눌렀을 때 발생하는 액션
        // deleteButtontapped 액션이 실행될때 삭제할 것인지 확인받은 alert을 위한 enum 추가
        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {
            case confirmDletion(id: Contact.ID) // Alert에서 삭제!!를 눌렀을 때 발생하는 액션
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(contact: Contact(id: UUID(), name: ""))
                return .none
//            case .addContact(.presented(.cancelButtonTapped)):
//                state.addContact = nil
//                return .none
//                
//            case .addContact(.presented(.saveButtonTapped)):
//                guard let newContact = state.addContact?.contact else { return .none }
//                state.contacts.append(newContact)
//                state.addContact = nil
//                return .none
                
//            case .addContact(.presented(.delegate(.cancel))):
//                state.addContact = nil
//                return .none
                
            case let .addContact(.presented(.delegate(.saveContact(contact)))):
                state.contacts.append(contact)
//                state.addContact = nil
                return .none
                
            case .addContact:
                return .none
                
            case .alert(.presented(.confirmDletion(id: let id))):
                state.contacts.removeAll { $0.id == id }
                return .none
                
            case .alert:
                return .none
                
            case .deleteButtonTapped(id: let id):
                state.alert = AlertState {
                    TextState("진짜 삭제?")
                } actions:
                {
                    ButtonState(role: .destructive, action: .confirmDletion(id: id)) {
                        TextState("삭제!!")
                    }
                }
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
