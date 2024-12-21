//
//  ProfileDetailView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/19/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ProfileDetailView: View {
    @Perception.Bindable var store: StoreOf<ProfileDetailFeature>
    
    var body: some View {
        Form {
            TextField("Name", text: $store.editedName)
            Toggle("Notifications", isOn: .constant(store.selectedPerson.isNotificationsEnabled))
            
            Button("Update") {
                store.send(.updateButtonTapped)
            }
            Button("Close") {
                store.send(.dismissModal)
            }
        }
    }
}

