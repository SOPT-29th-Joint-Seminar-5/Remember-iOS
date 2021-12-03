//
//  MainService.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/30.
//

import Foundation

import Moya

enum MainService {
    case category
    case main
}

extension MainService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .category:
            return "/main/tag"
        case .main:
            return "/main"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .category, .main:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .category, .main:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
