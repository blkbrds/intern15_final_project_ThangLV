//
//  TabBarController.swift
//  MyApp
//
//  Created by PCI0008 on 2/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage.init(systemName: "house"), tag: 0)
        let homeNavigationController = NavigationController(rootViewController: homeViewController)
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage.init(systemName: "magnifyingglass"), tag: 1)
        let searchNavigationController = NavigationController(rootViewController: searchViewController)
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage.init(systemName: "heart.fill"), tag: 2)
        let favoriteNavigationController = NavigationController(rootViewController: favoriteViewController)
        viewControllers = [homeNavigationController, searchViewController, favoriteViewController]
    }
}
