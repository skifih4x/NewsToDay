//
//  ListSection.swift
//  NewsToDay
//
//  Created by mac on 5/8/23.
//

import Foundation

enum Section {
    case categories
    case lastNews(news: [Article])
    case recommended(sources: [Source])
    
    

    var title: String {
        switch self {
        case .categories:
            return ""
        case .lastNews:
            return ""
        case .recommended:
            return "Recommended For You"
        }
    }
}


