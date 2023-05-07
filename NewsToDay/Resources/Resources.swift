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
        static var separator = UIColor(hex: 0xACAFC352)
    }
    
    enum Icons {
        enum TabBar {
            static var home = UIImage(named: "tabBarHome.svg")
            static var categories = UIImage(named: "tabBarApps.svg")
            static var bookmarks = UIImage(named: "tabBarBookmark.svg")
            static var profile = UIImage(named: "tabBarUser.svg")
        }
    }
}
