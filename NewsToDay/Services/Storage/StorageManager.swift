//
//  StorageManager.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation
import RealmSwift

protocol StorageManagerProtocol {
    func save(article: ArticleModel)
    func retrieve() -> [ArticleModel]
    func clearDB()
}

class StorageManager: StorageManagerProtocol {
    fileprivate lazy var mainRealm = try! Realm()
    
    func save(article: ArticleModel) {
        try! mainRealm.write {
            mainRealm.add(article)
        }
    }
    
    func retrieve() -> [ArticleModel] {
        let articles = mainRealm.objects(ArticleModel.self)
        
        return Array(articles)
    }
    
    func clearDB() {
        try! mainRealm.write {
            mainRealm.deleteAll()
        }
    }
}
