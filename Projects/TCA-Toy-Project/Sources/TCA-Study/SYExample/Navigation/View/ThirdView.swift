//
//  ThirdT.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/27/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ThirdView: View {
    let store: StoreOf<ThirdFeature>
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Here is ThirdView")
                .font(.largeTitle)
            
            Text("Go To FourthView")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.black)
                .foregroundStyle(.white)
                .onTapGesture {
                    store.send(.goToFourthView)
                }
            
            Text("Back To SecondView")
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red)
                .onTapGesture {
                    store.send(.backToSecondView)
                }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ThirdView(store: Store(initialState: ThirdFeature.State(), reducer: {
        ThirdFeature()
    }))
}
