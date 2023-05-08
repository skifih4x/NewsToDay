//
//  NetworkManager.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    let apikey = "ae7ec2d4e3664bf3bd4d73ebca4f516f"
    let baseUrl = "https://newsapi.org/v2/"
    
    func fetchSearch(query: String, completion: @escaping (Result<Welcome, Error> ) -> Void) {
        let url = "\(baseUrl)everything?q=\(query)&sortBy=popularity&apiKey=\(apikey)"
        
        guard let urlString = URL(string: url) else { return }
        print(urlString)
        URLSession.shared.dataTask(with: urlString) { data, _, error in
            guard let data = data else {
                completion(.failure(error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Welcome.self, from: data)
                completion(.success(result))
                print(result)
            } catch {
                print(error)
            }
        }.resume()
    }
}
