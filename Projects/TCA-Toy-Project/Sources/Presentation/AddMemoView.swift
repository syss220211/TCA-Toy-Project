//
//  AddMemoView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 1/2/25.
//  Copyright © 2025 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct AddMemoView: View {
    
    @State var tappedType: MemoType = .ideas
    @State var input: String = ""
    @State var editorInput: String = ""
    var action: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack{
                Spacer()
                TText("Save", fontType: .body1, color: Color.white)
                    .padding(.init(top: 4, leading: 20, bottom: 4, trailing: 20))
                    .background(Color.oliveT)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(alignment: .trailing)
                    .onTapGesture {
                        action?()
                    }
            }
            .padding(.horizontal, 31)
            
            ChipView(tappedType: $tappedType)
                .tap {
                    print("tapped")
                }
                .padding(.leading, 24)
            
            Rectangle()
                .fill(Color.divider)
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            VStack(alignment: .trailing, spacing: 0) {
                TextField(
                    "",
                    text: $input,
                    prompt: Text("Memo Title")
                        .font(TFont.body1.toFont)
                        .foregroundColor(Color.Ttextholder),
                    
                    axis: .horizontal
                )
                .onReceive($input.wrappedValue.publisher.collect()) {
                    var s = String($0.prefix(30))
                    s = s.filter { !$0.isWhitespace }
                    if $input.wrappedValue != s && (30 != 0) {
                        $input.wrappedValue = s
                    }
                }
                .padding(15)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray5, lineWidth: 1)
                }
                TText("\(input.count) / 30", fontType: .caption1, color: .TextSub2)
            }
            .padding(.horizontal, 31)
            
            VStack(alignment: .trailing, spacing: 0) {
                TextEditor(text: $editorInput)
                    .frame(height: 300)
                    .applyFont(font: .body1)
                    .foregroundStyle(Color.textMain)
                    .padding(8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray5)
                    }
                    .overlay(alignment: .topLeading) {
                        TText("Write your memo", fontType: .body1, color: Color.Ttextholder)
                            .padding(15)
                            .opacity(editorInput.isEmpty ? 1 : 0)
                    }
                    .onReceive(editorInput.publisher.collect(), perform: { input in
                        editorInput = String(input.prefix(200))
                    })
                
                TText("\(editorInput.count) / 200", fontType: .caption1, color: .TextSub2)
            }
            .padding(.horizontal, 31)
        }
    }
}

#Preview {
    AddMemoView()
}
