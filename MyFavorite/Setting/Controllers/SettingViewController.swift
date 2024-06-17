//
//  SettingViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class SettingViewController: UIViewController {
    lazy var userInfo = getUserInfo() {
        didSet {
            rootView.userInfo = userInfo
        }
    }
    private lazy var rootView = SettingRootView(userInfo: userInfo)

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavi()
        rootView.settingRootViewDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userInfo = getUserInfo()
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

extension SettingViewController: SettingRootViewDelegate {
    func selectCell(index: Int) {
        let alert = UIAlertController(
            title: Constant.LiteralString.Alert.Title.alert.rawValue,
            message: Constant.LiteralString.Alert.message,
            preferredStyle: .alert)

        let confirm = UIAlertAction(
            title: Constant.LiteralString.Alert.Title.confirm.rawValue,
            style: .default,
            handler: {_ in 
                self.confirmButtonTapped()
            })

        let cancel = UIAlertAction(
            title: Constant.LiteralString.Alert.Title.cancel.rawValue,
            style: .cancel,
            handler: nil)

        alert.addAction(cancel)
        alert.addAction(confirm)

        present(alert, animated: true)
    }

    private func confirmButtonTapped() {
        UserDefaultManager.removeAll()

        let onBoardingVC = OnBoardingViewController()
        moveNextVCWithWindow(vc: onBoardingVC)
    }

    func editButtonTapped() {
        let editProfileVC = SetNicknameViewController(state: .edit)
        moveNextVC(vc: editProfileVC)
    }
}
