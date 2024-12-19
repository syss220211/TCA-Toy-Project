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
    struct State {
        var contact: Contact
    }
    
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case delegate(Delegate)
        case setName(String)
        
        enum Delegate {
//            case cancel
            case saveContact(Contact)
        }
    }
    
    // 자식이 부조와 직접 접촉하지 않고도 스스로를 해제할 수 있도록 하기 위한 종속성 추가
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
//                return .none
//                return .send(.delegate(.cancel))
                return .run { _ in await self.dismiss() }
                
            case .saveButtonTapped:
//                return .none
//                return .send(.delegate(.saveContact(state.contact)))
                return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                }
                
            case .setName(let name):
                state.contact.name = name
                return .none
                
            case .delegate:
                return .none
            }
        }
    }   
}
