//
//  API.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 09.05.2023.
//

import Foundation

struct API {
    static let baseURL: URL = {
        guard let url = URL(string: "https://newsdata.io") else {
            preconditionFailure("News API is unavailable")
        }
        return url
    }()
    static let apiKey = "pub_22332f13bbb1a8edcaab9f87eefcd693f63ed"
    static let path = "/api/1/news"
}
