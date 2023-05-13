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

    //MARK: Метод для поиска, выкидывает объект типа NewsModel
    func fetchSearch(
        searchText: String,
        completion: @escaping (Result<NewsModel, Error>) -> Void
    ) {
        let searchURL = urlMaker.getURL(
            withPath: API.searchPath,
            baseURL: API.baseURL
        )
        let queryParams = [URLQueryItem(name: "q", value: searchText)]
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

    //MARK: Метод для получения превью топовых новостей, выкидывает объект типа HeadlineSources
    //если category == nil, то придут карточки по всем категориям
    func fetchHeadlinesSources(
        category: Category?,
        country: Country,
        completion: @escaping (Result<HeadlineSources, Error>) -> Void
    ) {
        let headlinesSourcesURL = urlMaker.getURL(
            withPath: API.headlineSourcesPath,
            baseURL: API.baseURL
        )

        var queryParams = [URLQueryItem]()
        queryParams.append(URLQueryItem(
            name: "country",
            value: country.rawValue
        ))
        if let category = category {
            queryParams.append(
                URLQueryItem(name: "category",
                             value: category.rawValue
                            )
            )
        }

        let headlinesSourceURLWithQueryParams = urlMaker.getURL(
            queryParams: queryParams,
            baseURL: headlinesSourcesURL
        )

        let request = requestMaker.makeGETRequest(
            url: headlinesSourceURLWithQueryParams
        )

        let task = session.objectTask(for: request) { (result:
            Result<HeadlineSources, Error>) in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        task.resume()
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

//MARK: Метод для получения списка топовых новостей, выкидывает объект типа NewsModel
extension NetworkManager {
    private enum FetchError: Error {
        case codeError
    }
    func fetchTopHeadlines(
        categories: [String],
        country: Country,
        completion: @escaping (Result<NewsModel, Error>) -> Void
    ) {
        let dispatchGroup = DispatchGroup()
        var allNews = [NewsModel]()

        for category in categories {
            dispatchGroup.enter()

            let topHeadlinesURL = urlMaker.getURL(
                withPath: API.topHeadlinesPath,
                baseURL: API.baseURL
            )

            let queryParams: [URLQueryItem] = [
                URLQueryItem(name: "category", value: category),
                URLQueryItem(name: "country", value: country.rawValue)
            ]
            let topHeadlinesURLWithCategory = urlMaker.getURL(
                queryParams: queryParams,
                baseURL: topHeadlinesURL
            )

            let request = requestMaker.makeGETRequest(
                url: topHeadlinesURLWithCategory
            )

            let task = session.dataTask(with: request) {
                data, response, error in
                if let error = error {
                    completion(.failure(error))
                    dispatchGroup.leave()
                }

                if let response = response as? HTTPURLResponse,
                   response.statusCode < 200 || response.statusCode > 299 {
                    completion(.failure(FetchError.codeError))
                    dispatchGroup.leave()
                }

                guard let data = data else {
                    completion(.failure(FetchError.codeError))
                    dispatchGroup.leave()
                    return
                }

                do {
                    let newsModel = try JSONDecoder().decode(NewsModel.self, from: data)
                    allNews.append(newsModel)
                }
                catch {
                    completion(.failure(FetchError.codeError))
                }
                dispatchGroup.leave()
            }
            task.resume()
        }

        dispatchGroup.notify(queue: .main) {
            if !allNews.isEmpty {
                let allArticles = allNews.flatMap( {$0.articles} )
                let combinedNewsModel = NewsModel(
                    status: "ok",
                    totalResults: allArticles.count,
                    articles: allArticles
                )
                completion(.success(combinedNewsModel))
            } else {
                completion(.failure(FetchError.codeError))
            }
        }
    }
}

