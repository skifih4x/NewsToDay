//
//  DataManager.swift
//  NewsToDay
//
//  Created by mac on 5/19/23.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let categoryKey = "SelectedCategory"
    private let newsKey = "SaveNews"
    
    func saveCategory(category: String) {
        UserDefaults.standard.set(category, forKey: categoryKey)
    }
    
    func loadSelectedCategory() -> String? {
        return UserDefaults.standard.string(forKey: categoryKey)
    }
    
    func saveNews(_ news: [Article]) {
        do {
            let encodedData = try JSONEncoder().encode(news)
            UserDefaults.standard.set(encodedData, forKey: newsKey)
        } catch {
            print("Failed to savenews data: \(error)")
        }
    }
    
    func loadData() -> [Article]? {
        guard let encodeData = UserDefaults.standard.data(forKey: newsKey) else { return nil }
        
        do {
            let decodedData = try JSONDecoder().decode([Article].self, from: encodeData)
            return decodedData
        } catch {
            print("Failed to savenews data: \(error)")
            return nil
        }
    }
    
}
