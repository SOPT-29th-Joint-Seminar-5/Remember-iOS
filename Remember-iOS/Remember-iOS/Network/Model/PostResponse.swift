//
//  PostResponse.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/12/03.
//

import Foundation

// MARK: - PostReponse
struct PostReponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Exist?
}

// MARK: - DataClass
struct Exist: Codable {
    let exist: Post
}

// MARK: - Exist
struct Post: Codable {
    let tagName, subject: String
    let nickname, duty: String?
    let contents: String
    let commentCnt, likeCnt: Int
}
