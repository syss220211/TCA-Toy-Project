//
//  CounterFeature.swift
//  TCA-Toy-Proejct
//
//  Created by 박서연 on 2024/12/14.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CounterFeature {
    @ObservableState
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case incrementButtonTapped
        case timerTick // 타이머가 일정 간격으로 액션을 발생시키기 위함
        case toggleTimerButtonTapped // 버튼 tapped 시 1초마다 timetick 액션이 발생됨
    }
    
    enum CancelID { case timer }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
                
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared
                        .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.factResponse(fact))
                }
                /*
                 run: Effect를 정의하는 방식 중 하나, 비동기 작업을 실행하는 클로저를 제공 -> async throws 사용
                 state.count 값을 클로저 내부에서 사용하기 위해서 count로 캡쳐하여 사용함
                 send : 비동기 작업 완료 후 Reducer로 새로운 액션을 보낼 수 있게하는 함수
                 
                 해당 비동기 작업의 결과를 처리하기 위해서 추가한 액션이 factResponse
                 TCA의 상태 변경은 무조건 Reducer를 통해서만 이루어져야 함
                 그렇기 때문에 비동기 작업이 완료된 후 작업의 결과를 상태에 반영하려면 별도의 액션을 정의해야 함
                 ==> factResponse
                 - HTTP 요청이 완료되면, factResponse 액션을 통해 Reducer에 요청 결과를 전달함
                 - Reducer는 factRespone 액션을 처리하여 상태를 업데이트 함
                 
                 */
                
            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none
                
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
                
            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none
                
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {
                    return .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1)) // 1초 간격으로 대기
                            await send(.timerTick) // 액션 전송
                        }
                    }
                    .cancellable(id: CancelID.timer) // 이 작업을 식별 가능하게 함 == 취소 가능한 작업으로 등록
                } else {
                    return .cancel(id: CancelID.timer) // 타이머 취소
                }
            }
        }
    }
}

