//
//  NewsModel.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation

struct NewsModel: Codable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title, description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}


