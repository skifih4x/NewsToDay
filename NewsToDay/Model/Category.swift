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
    case general
    case health
    case science
    case sports
    case technology

    static var categories: [String] {
        return self.allCases.map { $0.rawValue }
    }
}
