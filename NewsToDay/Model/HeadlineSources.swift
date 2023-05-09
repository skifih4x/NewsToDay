//
//  HeadlinesSources.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 09.05.2023.
//

import Foundation

struct HeadlineSources: Codable {
    let status: String
    let sources: [Source]
}

struct Source: Codable {
    let id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let country: String
}


