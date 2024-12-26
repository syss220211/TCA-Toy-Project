//
//  ChildeView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/26/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ChildView: View {
    
    @Perception.Bindable var store: StoreOf<ChildFeature>
    
    var body: some View {
        VStack {
            Text("Child View")
            Text("Shared Count \(store.sharedCounter)")
            Button ("+1") {
                store.send(.incrementCounter)
            }
        }
    }
}

#Preview {
    ChildView(store: Store(initialState: ChildFeature.State(sharedCounter: .init(value: 0)), reducer: {
        ChildFeature()
    }))
}
