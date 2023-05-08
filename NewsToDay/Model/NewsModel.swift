//
//  NewsModel.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation

struct Welcome: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}


