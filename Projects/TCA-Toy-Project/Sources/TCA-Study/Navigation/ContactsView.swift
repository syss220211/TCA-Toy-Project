//
//  ContactsVie.swift
//  App
//
//  Created by 박서연 on 2024/12/15.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    @Perception.Bindable var store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    HStack {
                        Text(contact.name)
                        Spacer()
                        Image(systemName: "trash")
                            .foregroundStyle(Color.red)
                            .onTapGesture {
                                print("contact.id = \(contact.id)")
                                store.send(.deleteButtonTapped(id: contact.id))
                            }
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(item: $store.scope(state: \.addContact, action: \.addContact)) { addContacts in
            NavigationStack {
                AddContactView(store: addContacts)
            }
        }
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    ContactsView(store: Store(initialState: ContactsFeature.State(
        contacts: [Contact(id: UUID(), name: "서연")]
    ), reducer: {
        ContactsFeature()
    }))
}
