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
    var results: [Article]
    let nextPage: String
}

struct Article: Codable {
    let title: String
    let keywords: [String]?
    let link: String
    let creator: [String]?
    let videoUrl: String?
    let description: String?
    let content: String?
    let pubDate: String
    let urlToImage: String?
    let sourceID: String
    let category: [String]
    let country: [String]
    let language: String

    private enum CodingKeys: String, CodingKey {
        case title
        case keywords
        case link
        case creator
        case videoUrl = "video_url"
        case description
        case content
        case pubDate
        case urlToImage = "image_url"
        case sourceID = "source_id"
        case category
        case country
        case language
    }
}


