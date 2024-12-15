//
//  TCA_Toy_ProejctApp.swift
//  TCA-Toy-Proejct
//
//  Created by 박서연 on 2024/12/12.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_Toy_ProejctApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
          ._printChanges()
      }
      
      var body: some Scene {
        WindowGroup {
          CounterView(store: TCA_Toy_ProejctApp.store)
        }
      }
}
