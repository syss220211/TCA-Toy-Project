//
//  ParentView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/26/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ParentView: View {
    
    @Perception.Bindable var store: StoreOf<ParentFeature>
    
    var body: some View {
        VStack {
            Text("Child View")
            Text("Shared Count \(store.sharedCounter)")
            Button ("+1") {
                store.send(.incrementCounter)
            }
            .padding(20)
            .background(Color.yellow)
            .foregroundStyle(Color.white)
            
            Button("go to childView") {
                store.send(.showChildView)
            }
        }
        .sheet(item: $store.scope(state: \.childFeature, action: \.childFeature)) { childStore in
            ChildView(store: childStore)
        }
    }
}

#Preview {
    ParentView(store: Store(initialState: ParentFeature.State(sharedCounter: .init(value: 0)), reducer: {
        ParentFeature()
    }))
}
