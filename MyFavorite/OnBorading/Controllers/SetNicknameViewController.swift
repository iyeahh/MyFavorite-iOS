//
//  SetNicknameViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class SetNicknameViewController: UIViewController {
    let profile: Profile

    var nickname: String? {
        didSet {
            rootView.nickname = nickname
        }
    }

    lazy var image = 0 {
        didSet {
            rootView.profileImage = image
        }
    }

    private lazy var rootView = SetNicknameView(state: profile.state)

    init(state: State) {
        self.profile = Profile(state: state)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        image = profile.setImage()
        if profile.state == .edit {
            nickname = UserDefaultManager.nickname
        }
    }

    private func configureNavi() {
        if profile.state == .create {
            navigationItem.title = State.create.rawValue
            let _ = UserDefaultManager.resetTempImage
        } else {
            navigationItem.title = State.edit.rawValue

            let barButtonItem = UIBarButtonItem(title: Constant.LiteralString.Title.Button.save, style: .plain, target: self, action: #selector(saveButtonTapped))
            barButtonItem.tintColor = Constant.Color.primary
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }

    @objc private func saveButtonTapped() {
        guard profile.isPossible(nickname: nickname) || nickname == UserDefaultManager.nickname else {
            return
        }
        UserDefaultManager.editUserInfo(nickname: nickname, image: image)
        navigationController?.popViewController(animated: true)
    }
}

extension SetNicknameViewController: SetNicknameViewDelegate {
    func setImageButtonTapped() {
        let selectImageVC = SelectImageViewController(profile: profile, image: image)
        moveNextVC(vc: selectImageVC)
    }
    
    func textFieldDidChange(_ sender: UITextField) {
        let message = profile.determineNickname(input: sender.text)
        rootView.descriptionContent = message
        nickname = sender.text
    }

    func completeButtonTapped() {
        guard profile.isPossible(nickname: nickname) else {
            return
        }
        UserDefaultManager.createUserInfo(nickname: nickname, image: image)

        let rootView = TabBarViewController()
        moveNextVCWithWindow(needNavi: false, vc: rootView)
    }
}
