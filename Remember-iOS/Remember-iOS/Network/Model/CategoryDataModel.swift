//
//  CategoryDataModel.swift
//  Remember-iOS
//
//  Created by EUNJU on 2021/12/03.
//

import Foundation

// MARK: - ResponseData

struct CategoryResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: CategoryResultData?
}

// MARK: - ResultData

struct CategoryResultData: Codable {
    let tagList: [String]
    let image: String
}
