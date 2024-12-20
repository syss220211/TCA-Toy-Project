//
//  ToyProjectAPP.swift
//  App
//
//  Created by 박서연 on 2024/12/12.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

//@main
//struct ToyProjectAPP: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

@main
struct ToyProjectApp: App {
//    static let store = Store(initialState: CounterFeature.State()) {
//        CounterFeature()
//            ._printChanges()
//    }
    
    static let store = Store(
        initialState: ContactsFeature.State(
            contacts: [
                Contact(id: UUID(), name: "Blob"),
                Contact(id: UUID(), name: "Blob Jr"),
                Contact(id: UUID(), name: "Blob Sr"),
            ]
        )
    ) {
        ContactsFeature()
    }
    var body: some Scene {
        WindowGroup {
//            CounterView(store: ToyProjectApp.store)
            ContactsView(store: Store(initialState: ContactsFeature.State(), reducer: {
                ContactsFeature()
            }))
        }
    }
}
