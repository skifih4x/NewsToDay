//
//  ListSection.swift
//  NewsToDay
//
//  Created by mac on 5/8/23.
//

import Foundation

enum Section {
    case categories([ListItem])
    case new([ListItem])
    case recommended([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .categories(let items),
        .new(let items),
        .recommended(let items):
        return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .categories:
            return ""
        case .new:
            return ""
        case .recommended:
            return "RECOMMENDED FOR YOU"
        }
    }
}



struct ListItem {
    let title: String
    let category: String
    let image: String
}


