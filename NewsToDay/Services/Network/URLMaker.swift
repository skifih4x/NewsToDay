//
//  URLMaker.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 09.05.2023.
//

import Foundation

final class URLMaker {
    static let shared = URLMaker()

    func getURL(withPath: String, baseURL: URL) -> URL {
        if var urlComponents = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: false
        ) {
            urlComponents.path = withPath

            guard let url = urlComponents.url else {
                preconditionFailure(
                    "Cannot implement \(baseURL) with path \(withPath)"
                )
            }
            return url
        } else {
            preconditionFailure(
                "Cannot implement URLComponents for URL: \(baseURL)"
            )
        }
    }

    func getURL(queryParams: [URLQueryItem], baseURL: URL) -> URL {
        guard let urlComponents = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: false
        ) else {
            preconditionFailure("URL: \(baseURL) is unavailable")
        }

        var composedURL = urlComponents
        composedURL.queryItems = queryParams

        guard let url = composedURL.url else {
            preconditionFailure(
                "Unable to construct composed URL: \(baseURL)"
            )
        }
        return url
    }
}
