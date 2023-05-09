//
//  TabBarController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import UIKit

enum Tabs: Int {
    case home
    case categories
    case bookmarks
    case profile
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inactive
        tabBar.backgroundColor = .white
        
        tabBar.layer.cornerRadius = 12
        tabBar.layer.borderColor = Resources.Colors.separator.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let homeController = HomeViewController()
        let categoriesController = CategoriesViewController()
        let bookmarksController = BookmarksViewController()
        let profileController = ProfileViewController()
        
        let homeNavigation = UINavigationController(rootViewController: homeController)
        let categoriesNavigation = UINavigationController(rootViewController: categoriesController)
        let bookmarksNavigation = UINavigationController(rootViewController: bookmarksController)
        let profileNavigation = UINavigationController(rootViewController: profileController)
        
        homeNavigation.tabBarItem = UITabBarItem(title: nil,
                                                 image: Resources.Icons.TabBar.home,
                                                 tag: Tabs.home.rawValue)
        categoriesController.tabBarItem = UITabBarItem(title: nil,
                                                 image: Resources.Icons.TabBar.categories,
                                                 tag: Tabs.categories.rawValue)
        bookmarksController.tabBarItem = UITabBarItem(title: nil,
                                                 image: Resources.Icons.TabBar.bookmarks,
                                                 tag: Tabs.bookmarks.rawValue)
        profileController.tabBarItem = UITabBarItem(title: nil,
                                                 image: Resources.Icons.TabBar.profile,
                                                 tag: Tabs.profile.rawValue)
        
        setViewControllers([
            homeNavigation,
            categoriesController,
            bookmarksController,
            profileController,
        ], animated: false)
        
        
    }
}
