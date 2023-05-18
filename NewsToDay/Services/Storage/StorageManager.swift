//
//  StorageManager.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation
import RealmSwift

protocol StorageManagerProtocol {
    func save(article: Article, category: String)
    func retrieveAll() -> [BookmarkModel]
    func hasObjectInStorage(with url: String) -> Bool
    func deleteItem(by key: String)
    func clearDB()
}

class StorageManager: StorageManagerProtocol {
    fileprivate lazy var mainRealm = try! Realm()
    
    func save(article: Article, category: String) {
        let a = BookmarkModelObject(article: article, category: category)
        
        try! mainRealm.write {
            mainRealm.add(a)
        }
    }
    
    func retrieveAll() -> [BookmarkModel] {
        var bookmarkAny: [BookmarkModel] = []
        
        let bookmarks = mainRealm.objects(BookmarkModelObject.self)
        for bookmark in bookmarks {
            bookmarkAny.append(BookmarkModel(title: bookmark.title,
                                             url: bookmark.url,
                                             urlToImage: bookmark.urlToImage,
                                             category: bookmark.category))
        }
        return bookmarkAny
    }
    
    func hasObjectInStorage(with key: String) -> Bool {
        if let _ = mainRealm.object(ofType: BookmarkModelObject.self, forPrimaryKey: key) {
            return true
        } else {
            return false
        }
    }
    
    func deleteItem(by key: String) {
        if let object = mainRealm.object(ofType: BookmarkModelObject.self, forPrimaryKey: key) {
            try! mainRealm.write {
                mainRealm.delete(object)
            }
        }
    }
    
    func clearDB() {
        try! mainRealm.write {
            mainRealm.deleteAll()
        }
    }
}
