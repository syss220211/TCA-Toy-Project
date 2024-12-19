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
                    // store.send(.resetForm)
                }
                .disabled(store.isNameTooLong)
                .foregroundStyle(store.isNameTooLong ? Color.red : Color.green)
                
                if store.isNameTooLong {
                    Text("Name is too long! Name's count could be under the 10")
                }
            }
            
            List(store.people, id: \.id) { person in
                Text(person.name)
            }
        }
    }
}

#Preview {
    ProfileView(store: Store(initialState: ProfileFeature.State(), reducer: {
        ProfileFeature()
    }))
}
