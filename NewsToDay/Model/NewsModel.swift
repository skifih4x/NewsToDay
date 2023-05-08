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
//    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}

//struct Source: Codable {
//    let id: ID?
//    let name: String
//}
//
//enum ID: String, Codable {
//    case businessInsider = "business-insider"
//    case dieZeit = "die-zeit"
//    case engadget = "engadget"
//    case googleNews = "google-news"
//    case wired = "wired"
//}
