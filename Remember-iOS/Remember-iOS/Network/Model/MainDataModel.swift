//
//  MainDataModel.swift
//  Remember-iOS
//
//  Created by EUNJU on 2021/12/02.
//

import Foundation

// MARK: - ResponseData

struct MainResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: MainResultData?
}

struct MainListResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: MainDataClass?
}

// MARK: - ResultData

struct MainResultData: Codable {
    let tagList: [String]
    let image: String
}

// MARK: - DataClass
struct MainDataClass: Codable {
    let mainList: [MainList]
    let image: String
}

// MARK: - MainList
struct MainList: Codable {
    let id: Int
    let subject, tagName: String
    let commentCnt, likeCnt: Int
}

