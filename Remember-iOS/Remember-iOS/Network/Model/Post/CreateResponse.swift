//
//  CreateResponse.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/12/03.
//

import Foundation

// MARK: - CreateResponse
struct CreateResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: NewPost?
}

// MARK: - PostData
struct NewPost: Codable {
    let post: Post
}

// MARK: - NewPost
struct Post: Codable {
    let id, communityID: Int
    let subject, contents: String
    let nickname, duty: String?
    let commentCnt, likeCnt: Int

    enum CodingKeys: String, CodingKey {
        case id
        case communityID = "communityId"
        case subject, nickname, commentCnt, likeCnt, duty, contents
    }
}
