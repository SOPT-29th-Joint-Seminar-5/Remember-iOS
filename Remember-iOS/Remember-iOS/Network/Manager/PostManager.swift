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
    private var postModel: DetailReponse?
    private var createModel: CreateResponse?
    
    // MARK: - Initializer
    
    private init() { }
    
    // MARK: - Public Properties
    
    public private(set) var contents: [Content] = [
        Content("손이 너~무 느린 후임 어떡하죠..", "닉네임", "웹.앱 디자인", "8분 전", "제가 성격이 급한 편이긴 한데..\n어떻게 잘 가르쳐야 할까요?", ["디자이너", "직무톡"], [Comment("닉네임2", "이참에 iOS개발자가 되는 건 어떤가요?", "3분전")])
    ]
    
    public private(set) var title: String = ""
    public private(set) var nickname: String? = "닉네임2"
    public private(set) var duty: String? = "iOS개발자"
    public private(set) var content: String = ""
    public private(set) var tagName: String = ""
    public private(set) var views: Int = 0
    public private(set) var likes: Int = 0

}

// MARK: - Server
extension PostManager {
    // Get /post/{id}
    func fetchPost(id: Int, completion: @escaping ((DetailedPost?, Error?) -> ())) {
        authProvider.request(.post(id)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.postModel = try result.map(DetailReponse.self)
                    
                    guard let data = self?.postModel?.data?.exist else {
                        print("data is invalid")
                        return }
                    
                    self?.title = data.subject
                    self?.nickname = data.nickname
                    self?.duty = data.duty
                    self?.content = data.contents
                    self?.tagName = data.tagName
                    self?.views = data.commentCnt
                    self?.likes = data.likeCnt

                    completion(data, nil)
                    
                } catch(let err) {
                    print(err.localizedDescription)
                    completion(nil, err)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, err)
            }
        }
    }
    
    // Post /post
    func dispatchPost(tag: String, title: String, content: String, completion: @escaping ((Int, String) -> ())) {
        let param = PostRequest.init(tag, title, content)
        
        authProvider.request(.createPost(param)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.createModel = try result.map(CreateResponse.self)
                    
                    guard let data = self?.createModel else { return }

                    completion(data.status, data.message)
                    
                } catch(let err) {
                    print(err.localizedDescription)
                    completion(400, "파라미터 값이 잘못되었습니다.")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(500, "서버 내부 에러")
            }
        }
    }
}
