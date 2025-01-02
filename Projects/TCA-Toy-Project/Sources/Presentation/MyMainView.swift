//
//  MyMainView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 1/2/25.
//  Copyright © 2025 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct MyMainView: View {
    
    var testData = Memo.sampleData
    
    var body: some View {
        NavigationStack {
            ForEach(testData, id: \.id) { memo in
                
            }
        }
        .navigationTitle("My Memose")
    }
}

#Preview {
    MyMainView()
}
