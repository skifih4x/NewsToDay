//
//  RequestMaker.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 09.05.2023.
//

import Foundation

final class RequestMaker {
    static let shared = RequestMaker()

    func makeGETRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(API.apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
}
