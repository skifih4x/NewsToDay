//
//  TopHeadlines.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 09.05.2023.
//

import Foundation

enum Category: String, CaseIterable {
    case business
    case entertainment
    case environment
    case food
    case health
    case politics
    case science
    case sports
    case technology
    case top
    case tourism
    case world

    static var categories: [String] {
        return self.allCases.map { $0.rawValue }
    }
}
