//
//  SetNicknameViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class SetNicknameViewController: UIViewController {
    let profile = Profile()
    private let rootView = SetNicknameView()

    lazy var image = 0 {
        didSet {
            rootView.profileImage = image
        }
    }

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.setNicknameViewDelegate = self
        configureNavi()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let savedImage = UserDefaultManager.image else {
            image = profile.randomImage()
            return
        }
        image = savedImage
    }

    private func configureNavi() {
        navigationItem.title = Constant.LiteralString.Title.NavigationBar.profileSetting.rawValue
    }
}

extension SetNicknameViewController: SetNicknameViewDelegate {
    func setImageButtonTapped() {
        let selectImageVC = SelectImageViewController(profile: profile, image: image)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(selectImageVC, animated: true)
    }
    
    func textFieldDidChange(_ sender: UITextField) {
        let message = profile.determineNickname(input: sender.text)
        rootView.descriptionContent = message
        profile.nickname = sender.text
    }

    func completeButtonTapped() {
        guard profile.isPossible else {
            return
        }

        let dataString = Date.dateString

        UserDefaultManager.joinDate = dataString
        UserDefaultManager.nickname = profile.nickname
        UserDefaultManager.image = image

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate

        let rootView = TabBarViewController()
        sceneDelegate?.window?.rootViewController = rootView
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
