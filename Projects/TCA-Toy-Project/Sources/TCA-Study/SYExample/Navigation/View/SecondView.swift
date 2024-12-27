//
//  SecondView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/27/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct SecondView: View {
    @Perception.Bindable var store: StoreOf<SecondFeature>
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Here is SecondView")
                .font(.largeTitle)
            
            Text("Count!!! \(store.count ?? 0)")
                .font(.headline)
            Text("Increment Count")
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(Color.brown.opacity(0.5))
                .foregroundStyle(Color.white)
                .onTapGesture {
                    print("tapped \(store.count ?? 0)")
                    store.send(.incrementCount)
                }
            
            
            Text("Go To ThridView")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.black)
                .foregroundStyle(.white)
                .onTapGesture {
                    store.send(.goToThirdView)
                }
            
            Text("Back To FirstView")
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red)
                .onTapGesture {
                    store.send(.backToFirstView)
                }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    SecondView(store: Store(initialState: SecondFeature.State(count: 0), reducer: {
        SecondFeature()
    }))
}
