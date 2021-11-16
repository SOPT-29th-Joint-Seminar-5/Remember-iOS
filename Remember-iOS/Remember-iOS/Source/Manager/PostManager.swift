//
//  PostManager.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/16.
//

import Foundation

class PostManager {
    
    static let shared = PostManager()
    
    // MARK: - Initializer
    
    private init() { }
    
    private var contents: [Content] = [
        Content("손이 너~무 느린 후임 어떡하죠..", "닉네임", "웹.앱 디자인", "8분전", "제가 성격이 급한 편이긴 한데..\n어떻게 잘 가르쳐야 할까요?", ["디자이너", "직무톡"], [Comment("닉네임2", "이참에 iOS개발자가 되는 건 어떤가요?", "3분전")])
    ]
    
    func getContentCount() -> Int {
        return contents.count
    }
    
    func getTitle(index: Int) -> String {
        return contents[index].title
    }
    
    func getNickname(index: Int) -> String {
        return contents[index].nickname
    }
    
    func getJob(index: Int) -> String {
        return contents[index].job
    }
    
    func getTime(index: Int) -> String {
        return contents[index].time
    }
    
    func getContents(index: Int) -> String {
        return contents[index].content
    }
    
    func getCategory(index: Int) -> [String] {
        return contents[index].category
    }
    
    func getComment(index: Int) -> [Comment] {
        return contents[index].comment
    }
}
