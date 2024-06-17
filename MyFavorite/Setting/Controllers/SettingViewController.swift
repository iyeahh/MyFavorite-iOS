//
//  SettingViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class SettingViewController: UIViewController {
    lazy var userInfo = getUserInfo()
    private lazy var rootView = SettingRootView(userInfo: userInfo)

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavi()
    }
    
    private func configureNavi() {
        navigationItem.title = Constant.LiteralString.Title.NavigationBar.setting.rawValue
    }
}

extension SettingViewController {
    private func getUserInfo() -> UserInfo? {
        guard let image = UserDefaultManager.image,
              let nickname = UserDefaultManager.nickname,
              let joinDate = UserDefaultManager.joinDate else { return nil }

        return UserInfo(image: image, nickname: nickname, joinDate: joinDate)
    }
}
