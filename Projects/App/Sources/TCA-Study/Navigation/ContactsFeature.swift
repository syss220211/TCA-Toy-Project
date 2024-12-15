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
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<Contact> = []
        @Presents var addContact: AddContactFeature.State?
    }
    
    enum Action {
        case addButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                // TODO: Handle action
                return .none
            }
        }
    }
}
