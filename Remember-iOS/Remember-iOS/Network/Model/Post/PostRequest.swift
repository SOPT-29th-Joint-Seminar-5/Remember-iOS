//
//  PostRequest.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/30.
//

import Foundation

struct PostRequest: Codable {
    var tagName: String
    var subject: String
    var contents: String
    
    init(_ tagName: String, _ subject: String, _ contents: String) {
        self.tagName = tagName
        self.subject = subject
        self.contents = contents
    }
}
