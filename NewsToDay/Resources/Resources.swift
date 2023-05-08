//
//  Resource.swift
//  NewsToDay
//
//  Created by Andrey on 07.05.2023.
//

import Foundation
import UIKit

enum Resources {
    enum Colors {
        static var active = UIColor(hex: 0x475AD7)
        static var inactive = UIColor(hex: 0xACAFC3)
        static var separator = UIColor(hex: 0xACAFC3)
        
        static var purpleDark = UIColor(hex: 0x2536A7)
        static var purplePrimary = UIColor(hex: 0x475AD7)
        static var purpleLight = UIColor(hex: 0x8A96E5)
        static var purpleLighter = UIColor(hex: 0xEEF0FB)
        
        static var blackDark = UIColor(hex: 0x22242F)
        static var blackPrimary = UIColor(hex: 0x333647)
        static var blackLight = UIColor(hex: 0x44485F)
        static var blackLighter = UIColor(hex: 0x555A77)
        
        static var greyDark = UIColor(hex: 0x666C8E)
        static var greyPrimary = UIColor(hex: 0x7C82A1)
        static var greyLight = UIColor(hex: 0xACAFC3)
        static var greyLighter = UIColor(hex: 0xF3F4F6)
    }
    
    enum Icons {
        enum TabBar {
            static var home = UIImage(named: "tabBarHome.svg")
            static var categories = UIImage(named: "tabBarApps.svg")
            static var bookmarks = UIImage(named: "tabBarBookmark.svg")
            static var profile = UIImage(named: "tabBarUser.svg")
        }
        
        static var mail = UIImage(systemName: "envelope")
        static var lock = UIImage(systemName: "lock")
        static var eye = UIImage(systemName: "eye")
    }
}
