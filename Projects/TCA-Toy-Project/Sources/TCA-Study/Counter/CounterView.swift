//
//  TCA-CounterView.swift
//  App
//
//  Created by 박서연 on 2024/12/14.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

// MARK: - Simple Counter Example
 
import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("\(store.count)")
                    .modifier(SampleModify())
                HStack {
                    Button("-") {
                        store.send(.decrementButtonTapped)
                    }
                    .modifier(SampleModify())
                    
                    Button("+") {
                        store.send(.incrementButtonTapped)
                    }
                    .modifier(SampleModify())
                }
                
                Button("Fact") {
                    store.send(.factButtonTapped)
                }
                .modifier(SampleModify())
                
                Text("Fun story of number")
                Text(store.fact ?? "")
                
                Text("Reset")
                    .onTapGesture {
                        store.send(.makeInitial)
                    }
                    .font(.largeTitle)
                    .foregroundColor(Color.red)
                
                
            }
        }
    }
}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
    }))
}

struct SampleModify: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
    }
}

