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

// MARK: - ResultData

struct MainResultData: Codable {
    let tagList: [String]
    let image: String
}
