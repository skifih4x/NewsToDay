//
//  CategoriesDelegate.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 13.05.2023.
//

import Foundation

protocol CategoriesDelegate: AnyObject {
    func fetchLatestNews(for category: [String])
}
