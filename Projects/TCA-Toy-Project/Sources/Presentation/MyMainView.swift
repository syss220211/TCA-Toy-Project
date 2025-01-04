//
//  MyMainView.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 1/2/25.
//  Copyright © 2025 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

enum ViewCase {
    case notData
    case type
}

//class MyMainViewModel: ObservableObject {
//    @Published var tappedMemos: [Memo] = Memo.sampleData
//    @Published var filteredMemos: [Memo] = []
//    @Published var tappedType: MemoType = .all
//    @Published var viewType: ViewCase?
//    
//    func tapped(type: MemoType) {
//        filteredMemos = (type.rawValue == "all" ? tappedMemos : tappedMemos.filter { $0.type == type })
//    }
//    
//    func viewCase() -> ViewCase {
//        tappedMemos.isEmpty ? .notData : .type
//    }
//    
//    func initMemos() {
//        filteredMemos = tappedMemos
//    }
//}

@Reducer
struct MainFeature {
    @ObservableState
    struct State {
        var tappedType: MemoType = .all
        var viewCase: ViewCase?
        var memoList: [Memo] = Memo.sampleData
        var filteredMemos: [Memo] = []
        var tappedMemo: Memo?
        var path = StackState<Path.State>()
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case initMemos
        case initViewType
        case tappedType(MemoType)
        case filtering
        case destination(PresentationAction<Destination.Action>)
        case path(StackActionOf<Path>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .initMemos:
                state.filteredMemos = state.memoList
                return .none
                
            case .initViewType:
                state.viewCase = (state.filteredMemos.isEmpty ? ViewCase.notData : ViewCase.type)
                state.filteredMemos = state.memoList
                return .none
                
            case .tappedType(let memo):
                state.tappedType = memo
                return .none
                
            case .filtering:
                state.filteredMemos = (
                    state.tappedType.rawValue == "all"
                    ? state.memoList
                    : state.memoList.filter({ $0.type == state.tappedType })
                )
                return .none
                
            case let .destination(.presented(.addMemo(.delegate(.save(memo))))):
                state.memoList.append(memo)
                return .none
                
            case let .destination(.presented(.editMemo(.delegate(.delete(memo))))):
                state.tappedMemo = memo
                let index = state.memoList.firstIndex { $0.id == memo.id }
                guard let temp = index else { return .none}
                state.memoList.remove(at: temp)
                return .none
                
            case .destination:
                return .none
                
            case let .path(action):
                switch action {
                case .element(id: _, action: .addMemoView(.deleteMemo)):
                    state.path.removeLast()
                    return .none
                    
                case .element(id: _, action: .aditMemoView(.deleteMemo)):
                    state.path.removeLast()
                    return .none
                    
                case .element(id: let id, action: .addMemoView(.binding(_))):
                    return .none
                    
                case .element(id: let id, action: .addMemoView(.delegate(_))):
                    return .none
                case .element(id: let id, action: .addMemoView(.tappedMemoType(_))):
                    return .none
                case .element(id: let id, action: .aditMemoView(.binding(_))):
                    return .none
                case .element(id: let id, action: .aditMemoView(.addNewMemo)):
                    return .none
                case .element(id: let id, action: .aditMemoView(.delegate(_))):
                    return .none
                case .element(id: let id, action: .aditMemoView(.tappedMemoType(_))):
                    return .none
                case .element(id: let id, action: .aditMemoView(.editMemoType(_))):
                    return .none
                case .popFrom(id: let id):
                    return .none
                case .push(id: let id, state: let state):
                    return .none
                case .element(id: let id, action: .addMemoView(.addNewMemo)):
                    return .none
                case .element(id: let id, action: .addMemoView(.editMemoType(_))):
                    return .none
                }
                
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$destination, action: \.destination)
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case addMemoView(AddMemoFeature)
        case aditMemoView(AddMemoFeature)
    }
}

extension MainFeature {
    @Reducer
    enum Destination {
        case addMemo(AddMemoFeature)
        case editMemo(AddMemoFeature)
    }
}

struct MyMainView: View {
    
    @Perception.Bindable var store: StoreOf<MainFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    TText("My Memos", fontType: .title2, color: Color.textMain)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 17, leading: 14, bottom: 17, trailing: 0))
                    
                    Divider()
                    
                    ChipView(tappedType: store.tappedType, allHiden: false)
                        .tap { memoType in
                            store.send(.tappedType(memoType))
                        }
                        .padding(.vertical, 10)
                        
                    
                    Divider()
                        .padding(.bottom, 20)
                    
                    switch store.viewCase {
                    case .notData:
                        noneView()
                    case .type:
                        typeView()
                    default:
                        noneView()
                    }
                }
                
                Circle()
                    .fill(Color.eggyolkShade3)
                    .frame(width: 48, height: 48)
                    .overlay {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.white)
                            .padding(11)
                            .onTapGesture {
                                print("go to add memo view")
                            }
                    }
                    .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 14))
                
            }
            .onAppear {
                store.send(.initMemos)
            }
        } destination: { store in
            switch store.case {
            case .addMemoView(let store):
                AddMemoView(store: store)
                
            case .aditMemoView(let store):
                AddMemoView(store: store)
            }
        }
    }
 
    @ViewBuilder
    func noneView() -> some View {
        TText("Tap + to add a new memo.", fontType: .body1, color: .TextSub2)
    }
        
    @ViewBuilder
    func typeView() -> some View {
        ForEach(store.filteredMemos, id: \.id) { memo in
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(height: 169)
                .overlay {
                    VStack(alignment: .trailing, spacing: 6) {
                        HStack{
                            TText("Title", fontType: .body1)
                            Spacer()
                            TText(memo.type.rawValue, fontType: .body1, color: Color.eggyolk)
                        }
                        .padding(.vertical, 4)
                        
                        TText(memo.content, fontType: .body2, color: Color.TextSub2)
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(Color.oliveTint4)
                            .onTapGesture {
                                store.send(.destination(.presented(.addMemo(store!.tappedMemo))))
                            }
                            .frame(width: 24, height: 24)
                    }
                    .padding(24)
                }
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 46)
        .shadow(color: Color.black.opacity(0.1), radius: 60, x: 0, y: 10)
    }
}

#Preview {
    MyMainView(store: Store(initialState: MainFeature.State(), reducer: {
        MainFeature()
    }))
}
