//
//  SettingViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class SettingViewController: UIViewController {
    private var userInfo = UserDefaultManager.getUserInfo() {
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
        userInfo = UserDefaultManager.getUserInfo()
        rootView.settingRootViewDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userInfo = UserDefaultManager.getUserInfo()
    }

    private func configureNavi() {
        navigationItem.title = Constant.LiteralString.Title.NavigationBar.setting.rawValue
    }
}

extension SettingViewController: SettingRootViewDelegate {
    func selectCell(index: Int) {
        if index == 4 {
            guard let alert = userInfo?.makeAelrt(confirmButtonTapped: confirmButtonTapped) else { return }
            present(alert, animated: true)
        } else {
            return
        }
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
