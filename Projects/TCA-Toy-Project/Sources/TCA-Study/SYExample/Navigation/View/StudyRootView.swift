//
//  StudyRootView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/27/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct StudyRootView: View {
    @Perception.Bindable var router: StoreOf<StudyRootFeature>
    
    var body: some View {
        NavigationStack(path: $router.scope(state: \.path, action: \.path)) {
            Text("Fisrt")
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .onTapGesture {
                    print("tapped first")
                    router.send(.clickFirst)
                }
            
            Text("Second")
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .onTapGesture {
                    print("tapped Second")
                    router.send(.clickSecond)
                }
            
            Text("Third")
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .onTapGesture {
                    print("tapped Third")
                    router.send(.clickThird)
                }
            
            Text("Fourth")
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
                .onTapGesture {
                    print("tapped Third")
                    router.send(.clickFourth)
                }
            
        } destination: { store in
            switch store.case {
            case .firstFeature(let store):
                FirstView(store: store)
                
            case .secondFeature(let store):
                SecondView(store: store)
                
            case .thirdFeature(let store):
                ThirdView(store: store)
                
            case .fourthFeature(let store):
                FourthView(store: store)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    StudyRootView(router: Store(initialState: StudyRootFeature.State(), reducer: {
        StudyRootFeature()
    }))
}
