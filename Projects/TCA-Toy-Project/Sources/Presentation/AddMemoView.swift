//
//  AddMemoView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 1/2/25.
//  Copyright © 2025 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AddMemoFeature {
    @ObservableState
    struct State: Equatable {
        var tappedType: MemoType
        var title: String
        var content: String
        var memo: Memo
        var type: MemoType
        var deleteHiden: Bool
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case addNewMemo
        case delegate(Delegate)
        case deleteMemo
        case tappedMemoType(MemoType)
        case editMemoType(MemoType)
        
        enum Delegate: Equatable {
            case save(Memo)
            case delete(Memo)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .addNewMemo:
                state.memo = Memo(type: state.tappedType, title: state.title, content: state.content)
                return .run { [memo = state.memo] send in
                    await send(.delegate(.save(memo)))
                    await self.dismiss()
                }
            case .delegate:
                return .none

            case .deleteMemo:
                return .none
                
            case .tappedMemoType(let type):
                state.type = type
                return .none
                
            case .editMemoType(let type):
                state.tappedType = type
                return .none
            }
        }
    }
}

struct AddMemoView: View {

    @Perception.Bindable var store: StoreOf<AddMemoFeature>
    
    var body: some View {
        VStack(spacing: 20) {
            HStack{
                TText("Delete", fontType: .body1, color: Color.white)
                    .padding(.init(top: 4, leading: 20, bottom: 4, trailing: 20))
                    .background(Color.eggyolkTint1)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(alignment: .trailing)
                    .onTapGesture {
                        store.send(.deleteMemo)
                    }
                    .opacity(store.deleteHiden ? 1 : 0)
                
                Spacer()
                
                TText("Save", fontType: .body1, color: Color.white)
                    .padding(.init(top: 4, leading: 20, bottom: 4, trailing: 20))
                    .background(Color.oliveT)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(alignment: .trailing)
                    .onTapGesture {
                        store.send(.addNewMemo)
                    }
            }
            .padding(.horizontal, 24)
            
            ChipView(tappedType: store.tappedType)
                .tap { memoType in
                    store.send(.editMemoType(memoType))
                    store.send(.tappedMemoType(memoType))
                }

            Rectangle()
                .fill(Color.divider)
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            VStack(alignment: .trailing, spacing: 0) {
                TextField(
                    "",
                    text: $store.title,
                    prompt: Text("Memo Title")
                        .font(TFont.body1.toFont)
                        .foregroundColor(Color.Ttextholder),
                    
                    axis: .horizontal
                )
                .onReceive($store.title.wrappedValue.publisher.collect()) {
                    var s = String($0.prefix(30))
                    s = s.filter { !$0.isWhitespace }
                    if $store.title.wrappedValue != s && (30 != 0) {
                        $store.title.wrappedValue = s
                    }
                }
                .padding(15)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray5, lineWidth: 1)
                }
                TText("\($store.title.count) / 30", fontType: .caption1, color: .TextSub2)
            }
            .padding(.horizontal, 31)
            
            VStack(alignment: .trailing, spacing: 0) {
                TextEditor(text: $store.content)
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
                            .opacity(store.content.isEmpty ? 1 : 0)
                    }
//                    .onReceive($store.content.publisher.collect(), perform: { input in
//                        $store.content = String(input.prefix(200))
//                    })
                
                TText("\($store.content.count) / 200", fontType: .caption1, color: .TextSub2)
            }
            .padding(.horizontal, 31)
        }
    }
}

//#Preview {
//    AddMemoView(store: Store(initialState: AddMemoFeature.State(tappedType: .all, title: "title", content: "content", memo: .init(type: .ideas, title: "ideastitle", content: "ideacontent")), reducer: {
//        AddMemoFeature()
//    }))
//}
