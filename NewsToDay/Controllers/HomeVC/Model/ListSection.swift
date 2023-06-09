//
//  ListSection.swift
//  NewsToDay
//
//  Created by mac on 5/8/23.
//

import Foundation

enum Section {
    case categories
    case lastNews
    case recommended
    
    var title: String {
        switch self {
        case .categories:
            return ""
        case .lastNews:
            return ""
        case .recommended:
            return LocalizationManager.localizationManager.localizeString("HOME_HEADER_TITLE")
        }
    }
}


