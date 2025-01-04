//
//  Divider.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 1/2/25.
//  Copyright © 2025 yapp25-toy-project. All rights reserved.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        Rectangle()
            .fill(Color.divider)
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
}

#Preview {
    Divider()
}
