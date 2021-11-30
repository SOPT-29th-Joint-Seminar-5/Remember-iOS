//
//  PostService.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/30.
//

import Moya

enum PostService {
    case createPost(PostRequest)
    case post(Int)
}

extension PostService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .createPost:
            return "/post"
        case .post(let id):
            return "/post/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createPost:
            return .post
        case .post:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .createPost(let param):
            return .requestJSONEncodable(param)
        case .post:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

