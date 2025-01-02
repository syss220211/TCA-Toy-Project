//
//  Memo.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 1/2/25.
//  Copyright © 2025 yapp25-toy-project. All rights reserved.
//

import Foundation

struct Memo: Identifiable {
    let id = UUID()
    var type: MemoType
    var title: String
    var content: String
    
    static let sampleData: [Memo] = [
        .init(type: .ideas, title: "title1", content: "content1"),
        .init(type: .ideas, title: "title1", content: "content1"),
        .init(type: .important, title: "title1", content: "content1"),
        .init(type: .important, title: "title1", content: "content1"),
        .init(type: .personal, title: "title1", content: "content1"),
        .init(type: .personal, title: "title1", content: "content1"),
        .init(type: .task, title: "title1", content: "content1"),
        .init(type: .task, title: "title1", content: "content1"),
        .init(type: .task, title: "title1", content: "content1"),
        .init(type: .ideas, title: "title1", content: "content1")
    ]
}
