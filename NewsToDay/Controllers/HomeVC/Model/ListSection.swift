//
//  ListSection.swift
//  NewsToDay
//
//  Created by mac on 5/8/23.
//

import Foundation

enum Section {
    case categories([Category])
    case news([Article])
    case recommended([Article])
    
    var itemCount: Int {
        switch self {
        case .categories(let category):
            return category.count
        case .news(let news):
            return news.count
        case .recommended(let source):
            return source.count
        }
    }

    var title: String {
        switch self {
        case .categories:
            return ""
        case .news:
            return ""
        case .recommended:
            return "Recommended For You"
        }
    }
}


