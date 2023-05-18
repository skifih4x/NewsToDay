//
//  CategoriesStorage.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 10.05.2023.
//

import Foundation

final class CategoriesStorage {
    fileprivate let key = "SavedCategories"
    private let userDefaults = UserDefaults.standard

    static let shared = CategoriesStorage()

    var categories: [String] = []

    init() {
        updateCategoryList()
    }

    func set(category: String) {
        categories.append(category)
        saveCategories()
    }

    func delete(category: String) {
        categories.removeAll { $0 == category }
        saveCategories()
    }
    
    func updateCategoryList() {
        if let categories = userDefaults.object(forKey: key) as? [String] {
            self.categories = categories
        } else {
            self.categories = []
        }
    }

    private func saveCategories() {
        userDefaults.set(categories, forKey: key)
    }
}
