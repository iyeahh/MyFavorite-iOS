//
//  TabBarViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = Constant.Color.accent
        tabBar.unselectedItemTintColor = Constant.Color.secondaryGray

        let search = UINavigationController(rootViewController: SearchViewController())
        search.tabBarItem = UITabBarItem(title: Constant.LiteralString.Title.TabBar.search.rawValue, image: Constant.Image.Icon.search, tag: 0)

        let setting = UINavigationController(rootViewController: SettingViewController())
        setting.tabBarItem = UITabBarItem(title: Constant.LiteralString.Title.TabBar.setting.rawValue, image: Constant.Image.Icon.setting, tag: 0)

        setViewControllers([search, setting], animated: true)
    }
}
