//
//  API.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 09.05.2023.
//

import Foundation

struct API {
    static let baseURL: URL = {
        guard let url = URL(string: "https://newsapi.org") else {
            preconditionFailure("News API is unavailable")
        }
        return url
    }()
    static let apiKey = "40e005130c374a9c9fc275df7165a1ec"

    static let searchPath = "/v2/everything"
    static let topHeadlinesPath = "/v2/top-headlines"
    static let headlineSourcesPath = "/v2/top-headlines/sources"
}
