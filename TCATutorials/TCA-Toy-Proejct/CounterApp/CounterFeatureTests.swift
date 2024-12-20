//
//  CounterFeatureTests.swift
//  TCA-Toy-Proejct
//
//  Created by 박서연 on 2024/12/15.
//

import ComposableArchitecture

@Reducer
struct ProfileFeature {
    @Perception.@Bindable
    struct State: Equatable {
        var name: String = ""
        var isNotificationsEnabled: Bool = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>) // 바인딩 동작 처리
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer() // 바인딩 처리 로직 추가
    }
}
