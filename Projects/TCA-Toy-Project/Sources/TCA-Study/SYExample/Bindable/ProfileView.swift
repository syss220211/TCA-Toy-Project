//
//  ProfileView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/19/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
    @Perception.Bindable var store: StoreOf<ProfileFeature>
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $store.name)
                Toggle("Notifications", isOn: $store.isNotificationsEnabled)
                
                Button("Save") {
                    store.send(.saveProfile)
                }
                .disabled(store.isNameTooLong)
                .foregroundStyle(store.isNameTooLong ? Color.red : Color.green)
                
                if store.isNameTooLong {
                    Text("Name is too long! \nName's count could be under the 10")
                }
            }
            
            List(store.state.people, id: \.id) { person in
                Text(person.name)
                    .onTapGesture {
                        store.send(.tappedPerson(person))
                    }
            }
        }
        .sheet(item: $store.scope(state: \.detailPerson, action: \.detailPerson)) { detailPerson in
            ProfileDetailView(store: detailPerson)
        }
        
    }
}

#Preview {
    NavigationStack {
        ProfileView(store: Store(initialState: ProfileFeature.State(), reducer: {
            ProfileFeature()
        }))
    }
}
