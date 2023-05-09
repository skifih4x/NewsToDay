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
            preconditionFailure("NEWS API is unavailable")
        }
        return url
    }()
    static let apiKey = "e924f9185069429a9782aca2d7f46da1"

    static let searchPath = "/v2/everything"
}
