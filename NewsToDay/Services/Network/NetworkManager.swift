//
//  NetworkManager.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()

    private let urlMaker = URLMaker.shared
    private let session = URLSession.shared
    
    func fetchSearch(
        queryParams: [URLQueryItem],
        completion: @escaping (Result<NewsModel, Error>) -> Void
    ) {
        let searchURL = urlMaker.getURL(withPath: API.searchPath, baseURL: API.baseURL)
        let urlWithQueryParam = urlMaker.getURL(queryParams: queryParams, baseURL: searchURL)

        let request = makeRequest(url: urlWithQueryParam)

        let task = session.objectTask(for: request) { (result:
            Result<NewsModel, Error>) in
            switch result {
            case .success(let newsModel):
                completion(.success(newsModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func fetchTopHeadlines(
        category: TopHeadlines,
        country: Country,
        completion: @escaping (Result<NewsModel, Error>) -> Void
    ) {
        let topHeadlinesURL = urlMaker.getURL(
            withPath: API.topHeadlinesPath,
            baseURL: API.baseURL
        )

        let queryParam = [
            URLQueryItem(name: "country", value: country.rawValue),
            URLQueryItem(name: "category", value: category.rawValue)
        ]
        let topHeadlinesURLWithCategory = urlMaker.getURL(
            queryParams: queryParam,
            baseURL: topHeadlinesURL
        )

        let request = makeRequest(url: topHeadlinesURLWithCategory)

        let task = session.objectTask(for: request) { (result:
            Result<NewsModel, Error>) in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        task.resume()
    }

    private func makeRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(API.apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
}
