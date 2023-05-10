//
//  SectionData.swift
//  NewsToDay
//
//  Created by mac on 5/9/23.
//

import Foundation


struct SectionData {
    
    static let shared = SectionData()
    
    private let category: Section = {
        .categories([
            .init(title: "Random", category: "", image: ""),
            .init(title: "Sport", category: "", image: ""),
            .init(title: "Gaming", category: "", image: ""),
            .init(title: "Politics", category: "", image: "")
        ])
    }()
    
    private let new: Section = {
        .new([
            .init(title: "The last situationin election", category: "POLITICS", image: ""),
            .init(title: "An update", category: "ART", image: "")
        ])
    }()
    
    private let recommended: Section = {
        .recommended([
            .init(title: "A simple Trick For Creating", category: "UI/UX Design", image: ""),
            .init(title: "A simple Trick For Creating", category: "UI/UX Design", image: ""),
            .init(title: "A simple Trick For Creating", category: "UI/UX Design", image: "")
        ])
    }()
    
    var page: [Section] {
        [category, new, recommended]
    }
    
}
