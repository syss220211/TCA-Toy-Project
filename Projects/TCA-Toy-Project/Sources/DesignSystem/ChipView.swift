//
//  ChipView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 1/2/25.
//  Copyright © 2025 yapp25-toy-project. All rights reserved.
//

import SwiftUI

struct ChipView: View {
    
    var tappedType: MemoType
    var action: ((MemoType) -> Void)?
    var allHiden: Bool? = true
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(MemoType.allCases, id: \.self) { memo in
                    if allHiden! && memo.rawValue == "all" {
                        EmptyView()
                    } else {
                        TText(memo.rawValue, fontType: .body1, color: tappedType == memo ? Color.eggyolkTint6 : Color.eggyolkShade2)
                            .padding(.init(top: 1, leading: 8, bottom: 1, trailing: 8))
                            .background(tappedType == memo ? Color.eggyolkShade3 : .clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.eggyolkShade2, lineWidth: 2)
                                    .opacity(tappedType == memo ? 0 : 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .onTapGesture {
                                action?(tappedType)
                            }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.leading, 24)
    }
}

extension ChipView {
    func tap(action: @escaping ((MemoType) -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

#Preview {
    ChipView(tappedType: .personal)
}
