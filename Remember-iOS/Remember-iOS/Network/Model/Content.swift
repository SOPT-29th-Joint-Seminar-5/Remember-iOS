//
//  Content.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/16.
//

import Foundation

struct Content {
    var title: String
    var nickname: String
    var job: String
    var time: String
    var content: String
    var category: [String]
    var comment: [Comment]
    
    init(_ title: String,_ nickname: String = "닉네임",_ job: String,_ time: String,_ content: String,_ category: [String],_ comment: [Comment]) {
        self.title = title
        self.nickname = nickname
        self.job = job
        self.time = time
        self.content = content
        self.category = category
        self.comment = comment
    }
}

struct Comment {
    var nickname: String
    var content: String
    var time: String
    
    init(_ nickname: String = "닉네임",_ content: String,_ time: String) {
        self.nickname = nickname
        self.content = content
        self.time = time
    } 
}
