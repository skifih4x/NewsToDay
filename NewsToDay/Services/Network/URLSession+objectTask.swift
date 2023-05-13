//
//  URLSession+objectTask.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 09.05.2023.
//

import Foundation

extension URLSession {
    private enum FetchError: Error {
        case codeError
    }

    func objectTask<T: Decodable>(
        for request: URLRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> URLSessionTask {
        let globalQueue = DispatchQueue.global(qos: .utility)
        let mainQueue = DispatchQueue.main

        let task = dataTask(with: request) {
            data, response, error in
            globalQueue.async {
                if let error = error {
                    mainQueue.async {
                        completion(.failure(error))
                    }
                }

                if let response = response as? HTTPURLResponse,
                   response.statusCode < 200 || response.statusCode > 299 {
                    mainQueue.async {
                        completion(.failure(FetchError.codeError))
                    }
                }

                guard let data = data else {
                    mainQueue.async {
                        completion(.failure(FetchError.codeError))
                    }
                    return
                }

                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    mainQueue.async {
                        completion(.success(result))
                    }
                }
                catch {
                    mainQueue.async {
                        completion(.failure(FetchError.codeError))
                    }
                }
            }
        }
        return task
    }
}
