//
//  FirstView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/27/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct FirstView: View {
    let store: StoreOf<FirstFeature>
    
    var body: some View {
        VStack {
            Text("Here is FirstView")
                .font(.largeTitle)
            Text("Go to Second View")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.black)
                .foregroundStyle(.white)
                .onTapGesture {
                    store.send(.goToSecondView)
                }
            
            Text("Go To Root")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red)
                .foregroundStyle(.white)
                .onTapGesture {
                    store.send(.backToRoot)
                }
            
            Text("Go to Back")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.green)
                .foregroundStyle(.white)
                .onTapGesture {
                    store.send(.back)
                }
        }
    }
}

#Preview {
    FirstView(store: Store(initialState: FirstFeature.State(), reducer: {
        FirstFeature()
    }))
}
