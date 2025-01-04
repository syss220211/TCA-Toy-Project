//
//  Memo.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 1/2/25.
//  Copyright © 2025 yapp25-toy-project. All rights reserved.
//

import Foundation

struct Memo: Identifiable, Equatable {
    let id = UUID()
    var type: MemoType
    var title: String
    var content: String
    
    static let sampleData: [Memo] = [
        .init(type: .ideas, title: "title1", content: "Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add..."),
        .init(type: .ideas, title: "title2", content: "Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add..."),
        .init(type: .important, title: "title3", content: "Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add..."),
        .init(type: .important, title: "title4", content: "Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add..."),
        .init(type: .personal, title: "title5", content: "Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add..."),
        .init(type: .personal, title: "title6", content: "Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add..."),
        .init(type: .task, title: "title7", content: "Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add..."),
        .init(type: .task, title: "title8", content: "Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add..."),
        .init(type: .task, title: "title9", content: "Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add..."),
        .init(type: .ideas, title: "title10", content: "Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...Discussed Q4 planning and team objectives for the upcoming sprint... dont know what to add...")
    ]
}
