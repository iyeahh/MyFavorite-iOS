//
//  SetNicknameViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class SetNicknameViewController: UIViewController {
    
    private let rootView = SetNicknameView()

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.setNicknameViewDelegate = self
        configureNavi()
    }

    private func configureNavi() {
        navigationItem.title = Constant.LiteralString.Title.NavigationBar.profileSetting.rawValue
    }
}

extension SetNicknameViewController: SetNicknameViewDelegate {
    func textFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let message = text.determineNickname()
        rootView.descriptionContent = message
    }
}
