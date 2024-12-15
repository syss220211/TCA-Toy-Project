//
//  CounterView.swift
//  TCA-Toy-Proejct
//
//  Created by 박서연 on 2024/12/14.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
            Button("Fact") {
                store.send(.factButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            
            Text(store.isLoading ? "true" : "false")
                .font(.largeTitle)
                .foregroundStyle(Color.red)
            
            Text("Fun Fact: \(store.fact ?? "")")
                .font(.caption)
                .foregroundStyle(Color.purple)
            
            // Add Timer
            Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                store.send(.toggleTimerButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
        }
    }
}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
    }))
}
