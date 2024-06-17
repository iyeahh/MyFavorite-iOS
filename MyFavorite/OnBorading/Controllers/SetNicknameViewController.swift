//
//  SetNicknameViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class SetNicknameViewController: UIViewController {
    var state: State
    let profile = Profile()

    var nickname: String? {
        didSet {
            rootView.nickname = nickname
        }
    }

    private lazy var rootView = SetNicknameView(state: state)

    lazy var image = 0 {
        didSet {
            rootView.profileImage = image
        }
    }

    init(state: State) {
        self.state = state
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
        guard let savedImage = UserDefaultManager.image else {
            image = profile.randomImage()
            return
        }
        image = savedImage

        if state == .edit {
            nickname = UserDefaultManager.nickname
        }
    }

    private func configureNavi() {


        if state == .create {
            navigationItem.title = State.create.rawValue
        } else {
            navigationItem.title = State.edit.rawValue
            let barButtonItem = UIBarButtonItem(title: Constant.LiteralString.Title.Button.save, style: .plain, target: self, action: #selector(saveButtonTapped))
            barButtonItem.tintColor = Constant.Color.primary
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }

    @objc private func saveButtonTapped() {
        guard profile.isPossible else {
            return
        }

        UserDefaultManager.nickname = profile.nickname
        UserDefaultManager.image = image

        navigationController?.popViewController(animated: true)
    }
}

extension SetNicknameViewController: SetNicknameViewDelegate {
    func setImageButtonTapped() {
        let selectImageVC = SelectImageViewController(state: state, profile: profile, image: image)
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
