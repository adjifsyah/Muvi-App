//
//  CustomTabbar.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class CustomTabbar: UITabBarController , UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBar.appearance().barTintColor = .black
        tabBar.tintColor = UIColor(red: 1, green: 0.82, blue: 0.188, alpha: 1)
        self.tabBar.selectedItem?.badgeColor = UIColor(red: 1, green: 0.82, blue: 0.188, alpha: 1)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homePage = HomePageVC()
        let homeNavigation = UINavigationController(rootViewController: homePage)
        homeNavigation.isNavigationBarHidden = true
        let homeTabbar = UITabBarItem(title: "", image: UIImage(named: "tabHome"), tag: 1)
        homePage.tabBarItem = homeTabbar
        
        let searchPage = SearchPageVC()
        let searchNavigation = UINavigationController(rootViewController: searchPage)
        searchNavigation.isNavigationBarHidden = true
        let searchTabbar = UITabBarItem(title: "", image: UIImage(named: "tabSearch"), tag: 2)
        searchPage.tabBarItem = searchTabbar
        
        let favoritePage = FavoritePageVC()
        let favoriteNavigation = UINavigationController(rootViewController: favoritePage)
        favoriteNavigation.isNavigationBarHidden = true
        let favoriteTabbar = UITabBarItem(title: "", image: UIImage(named: "tabFavorite"), tag: 3)
        favoritePage.tabBarItem = favoriteTabbar
        
        let profilePage = UIViewController()
        let profileNavigation = UINavigationController(rootViewController: profilePage)
        profileNavigation.isNavigationBarHidden = true
        let profileTabbar = UITabBarItem(title: "", image: UIImage(named: "tabProfile"), tag: 4)
        profilePage.tabBarItem = profileTabbar
        
        self.viewControllers = [homeNavigation, searchNavigation,favoriteNavigation, profileNavigation]
        
    }
    

}
