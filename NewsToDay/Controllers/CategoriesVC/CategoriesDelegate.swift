//
//  CategoriesDelegate.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 13.05.2023.
//

import Foundation

protocol CategoriesDelegate: AnyObject {
    //func loadData()
    func fetchNewsModel(for category: String)
    func fetchHeadlineSource(for category: String)
}
