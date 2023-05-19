//
//  BookmarksModel.swift
//  NewsToDay
//
//  Created by Andrey on 14.05.2023.
//

import Foundation
import RealmSwift

@objcMembers
class BookmarkModelObject: Object {
    @Persisted var title: String?
    @Persisted var url: String = ""
    @Persisted var urlToImage: String?
    @Persisted var content: String?
    @Persisted var category: String = ""
    
    convenience init(article a: Article) {
        self.init()
        
        self.title = a.title
        self.url = a.link
        self.urlToImage = a.urlToImage
        self.content = a.content
        self.category = a.category.joined(separator: ", ")
    }
    
    override static func primaryKey() -> String? {
        return "url"
    }
}
