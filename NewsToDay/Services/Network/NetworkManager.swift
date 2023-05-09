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
    private let requestMaker = RequestMaker.shared
    private let session = URLSession.shared

    //MARK: Метод для поиска, выкидывает объект типа NewsModel
    func fetchSearch(
        queryParams: [URLQueryItem],
        completion: @escaping (Result<NewsModel, Error>) -> Void
    ) {
        let searchURL = urlMaker.getURL(
            withPath: API.searchPath,
            baseURL: API.baseURL
        )
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

    //MARK: Метод для получения списка топовых новостей, выкидывает объект типа NewsModel
    func fetchTopHeadlines(
        category: Category,
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

        let request = requestMaker.makeGETRequest(
            url: topHeadlinesURLWithCategory
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
}
