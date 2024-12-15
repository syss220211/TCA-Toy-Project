//
//  AddContactView.swift
//  App
//
//  Created by 박서연 on 2024/12/15.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct AddContactView: View {
    @BindingViewState var store: StoreOf<AddContactFeature>
    
    var body: some View {
        Form {
            TextField("Name", text: $store.contact.name.sending(\.setName))
            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

//#Preview {
//  NavigationStack {
//    AddContactView(
//      store: Store(
//        initialState: AddContactFeature.State(
//          contact: Contact(
//            id: UUID(),
//            name: "Blob"
//          )
//        )
//      ) {
//        AddContactFeature()
//      }
//    )
//  }
//}
