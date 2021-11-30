//
//  PostManager.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/30.
//

import Moya

final class PostManager {
    
    // MARK: - Static Properties
    
    static let shared: PostManager = PostManager()
    
    // MARK: - Network Properties
    
    private let authProvider = MoyaProvider<PostService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    // MARK: - Initializer
    
    private init() { }
    
    // MARK: - Public Properties
    
    public private(set) var contents: [Content] = [
        Content("손이 너~무 느린 후임 어떡하죠..", "닉네임", "웹.앱 디자인", "8분 전", "제가 성격이 급한 편이긴 한데..\n어떻게 잘 가르쳐야 할까요?", ["디자이너", "직무톡"], [Comment("닉네임2", "이참에 iOS개발자가 되는 건 어떤가요?", "3분전"), Comment("닉네임4", "iOS개발자가 되는게 맞는 거 같네요..", "3분전"), Comment("닉네임1", "저는 iOS 개발 추천이요!!", "3분전")]),
        Content("후배가 내 파트장이 된다면???", "닉네임", "웹.앱 디자인", "8분 전", "후배가 내 파트장이 된다고 합니다!!!! 축하해주세요!!!!", ["회사생활", "직무톡"], [Comment("닉네임2", "축하드려요~!~!✈️", "3분전")]),
        Content("이직 횟수가 많으면 잘못한 건가요?", "닉네임", "웹.앱 디자인", "8분 전", "저는 이직을 100번했습니다. 이직왕이라고 불러주세요~!\n이직을 하는게 저의 취미죠.", ["이직/연봉/커리어", "직무톡"], [Comment("닉네임2", "반갑습니다. 이직왕씨", "3분전")]),
        Content("올해 한국주식 투자하신분들 이익보셨나요?", "닉네임", "웹.앱 디자인", "8분 전", "제곧내", ["경제/재테크", "직무톡"], [Comment("닉네임2", "눈물 좔좔나네요.", "3분전")]),
        Content("디자이너 워라밸 실화인가여?", "닉네임", "웹.앱 디자인", "8분 전", "저는 디자이너고 집에 들어가본지 한달째네요. 집밥이 그립습니다...\n그냥 건강하게만 살고 싶은데...", ["회사생활", "직무톡"], [Comment("닉네임2", "아이고ㅜㅜㅜ 얼른 이직 준비하십쇼.", "3분전")]),
        Content("이직은 어떻게 하는건가요?", "닉네임", "웹.앱 디자인", "8분 전", "이직왕씨 이직을 어떻게 하는거죠.", ["이직/연봉/커리어", "직무톡"], [Comment("닉네임2", "@이직왕", "3분전")])
    ]
    
    public private(set) var index: Int = 0
    
    // MARK: - Set
    
    public func setIndex(to index: Int) {
        self.index = index
    }
    
    public func setComment(to comment: Comment) {
        contents[index].comment.append(comment)
    }
    
    public func createPost(title: String, content: String, category: String) {
        contents.append(Content(title, "닉네임", "IT 엔지니어", "8분 전", content, [category, "직무톡"], []))
    }

}
