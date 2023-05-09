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

        var request = URLRequest(url: urlWithQueryParam)
        request.setValue(API.apiKey, forHTTPHeaderField: "x-api-key")

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
}
