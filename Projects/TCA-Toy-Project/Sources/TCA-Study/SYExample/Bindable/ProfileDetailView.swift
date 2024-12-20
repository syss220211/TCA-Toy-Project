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
    let store: StoreOf<ProfileDetailFeature>
    
    var body: some View {
        VStack {
            Text("이름 \(store.selectedPerson?.name ?? "")")
            Text("NotificationValue: \(store.selectedPerson?.isNotificationsEnabled ?? false)")
            TextField(
                "Text",
                text: Binding(
                    get: { store.name },
                    set: { newValue in store.send(.setName(newValue)) }
                )
            )
            Button("Close") {
                store.send(.dismissModal(store.name))
            }
        }
    }
}
