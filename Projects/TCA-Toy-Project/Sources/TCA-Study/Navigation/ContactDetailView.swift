//
//  ContactDetailView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/26/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
    let store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        Form {
            
        }
        .navigationTitle(Text(store.contact.name))
    }
}

#Preview {
    NavigationStack {
        ContactDetailView(
            store: Store(
                initialState: ContactDetailFeature.State(
                    contact: Contact(id: UUID(), name: "서연")
                )
            ) {
                ContactDetailFeature()
            }
        )
    }
}
