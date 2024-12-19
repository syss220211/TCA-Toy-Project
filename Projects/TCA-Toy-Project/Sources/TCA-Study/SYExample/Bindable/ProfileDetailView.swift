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
    @Perception.Bindable var store: StoreOf<ProfileFeature>
    
    var body: some View {
        VStack {
            Text("")
        }
    }
}

#Preview {
    ProfileView(store: Store(initialState: ProfileFeature.State(), reducer: {
        ProfileFeature()
    }))
}
