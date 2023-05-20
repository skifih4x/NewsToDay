//
//  NetworkManager.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()

    private let urlMaker = URLMaker.shared
    private let requestMaker = RequestMaker.shared
    private let session = URLSession.shared
    private var task: URLSessionTask?

    //MARK: Метод для поиска, выкидывает объект типа NewsModel
    func fetchSearch(
        searchText: String,
        completion: @escaping (Result<NewsModel, Error>) -> Void
    ) {
        let searchURL = urlMaker.getURL(
            withPath: API.path,
            baseURL: API.baseURL
        )
        let queryParams = [
            URLQueryItem(name: "apikey", value: API.apiKey),
            URLQueryItem(name: "q", value: searchText)
        ]
        let urlWithQueryParam = urlMaker.getURL(
            queryParams: queryParams,
            baseURL: searchURL
        )

        let request = requestMaker.makeGETRequest(
            url: urlWithQueryParam
        )

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

    //MARK: Метод для получения актуальных новосте, выкидывает объект типа NewsModel
    //если category == nil, то придут карточки по всем категориям
    func fetchLatestNews(
        category: [String]?,
        country: Country,
        completion: @escaping (Result<NewsModel, Error>) -> Void
    ) {
        task?.cancel()
        
        let headlinesSourcesURL = urlMaker.getURL(
            withPath: API.path,
            baseURL: API.baseURL
        )

        var queryParams = [URLQueryItem]()
        queryParams.append(URLQueryItem(
            name: "apikey",
            value: API.apiKey
        ))
        queryParams.append(URLQueryItem(
            name: "country",
            value: country.rawValue
        ))
        if let category = category {
            let stringCategories = category.joined(separator: ",")
            queryParams.append(
                URLQueryItem(name: "category",
                             value: stringCategories
                            )
            )
        }

        let headlinesSourceURLWithQueryParams = urlMaker.getURL(
            queryParams: queryParams,
            baseURL: headlinesSourcesURL
        )

        print(headlinesSourceURLWithQueryParams)

        let request = requestMaker.makeGETRequest(
            url: headlinesSourceURLWithQueryParams
        )

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
        self.task = task
    }
    
    func fetchImage(url: String, imageView: UIImageView) {
            guard let url = URL(string: url) else {
                return
            }
            let mainQueue = DispatchQueue.main
            let globalQueue = DispatchQueue.global(qos: .utility)
            var data: Data?

            let workItem = DispatchWorkItem { data = try? Data(contentsOf: url) }

            globalQueue.async(execute: workItem)

            workItem.notify(queue: mainQueue) {
                if let imageData = data {
                    imageView.image = UIImage(data: imageData)
                }
            }
        }
}

