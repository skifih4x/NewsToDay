//
//  StorageManager.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation
import RealmSwift

protocol StorageManagerProtocol {
    func save(article: Article)
    func retrieve() -> [ArticleModel]
    func clearDB()
}

class StorageManager: StorageManagerProtocol {
    fileprivate lazy var mainRealm = try! Realm()
    
    func save(article: Article) {
        let a = ArticleModel(article: article)
        
        try! mainRealm.write {
            mainRealm.add(a)
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
