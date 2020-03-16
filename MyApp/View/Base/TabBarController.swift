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
        tabBar.tintColor = .red
        setupUI()
    }
    
    private func setupUI() {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "find"), tag: 1)
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "favor_1"), tag: 2)
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteViewController)
        viewControllers = [homeNavigationController, searchNavigationController, favoriteNavigationController]
    }
    
    private func animate(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
}
