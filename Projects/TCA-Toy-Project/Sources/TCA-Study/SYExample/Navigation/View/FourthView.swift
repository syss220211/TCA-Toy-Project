//
//  FourthView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 12/27/24.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct FourthView: View {
    
    let store: StoreOf<FourthFeature>
    
    var body: some View {
        VStack {
            Text("Here is FourthView")
                .font(.largeTitle)
            
            Text("Go to SeondView")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.orange)
                .onTapGesture {
                    store.send(.goToSecondView)
                }
            
            Text("Pop to FirstView")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.purple)
                .onTapGesture {
                    store.send(.popToFirstView)
                }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    FourthView(store: Store(initialState: FourthFeature.State(), reducer: {
        FourthFeature()
    }))
}
