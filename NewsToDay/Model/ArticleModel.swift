//
//  BookmarksModel.swift
//  NewsToDay
//
//  Created by Andrey on 14.05.2023.
//

import Foundation
import RealmSwift

@objcMembers
class ArticleModel: Object {
    @Persisted var author: String?
    @Persisted var title: String?
    @Persisted var desc: String?
    @Persisted var url: String = ""
    @Persisted var urlToImage: String?
    @Persisted var publishedAt: String = ""
    @Persisted var content: String?
    
    convenience init(article a: Article) {
        self.init()
        self.author = a.author
        self.title = a.title
        self.desc = a.description
        self.url = a.url
        self.urlToImage = a.urlToImage
        self.publishedAt = a.publishedAt
        self.content = a.content
    }
}
