//
//  ToyProjectAPP.swift
//  App
//
//  Created by 박서연 on 2024/12/12.
//  Copyright © 2024 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@main
struct ToyProjectAPP: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

