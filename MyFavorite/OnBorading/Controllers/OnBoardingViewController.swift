//
//  OnBoardingViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class OnBoardingViewController: UIViewController {
    private let rootView = OnBoardingView()

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.onBoardingViewDelegate = self
    }
}

extension OnBoardingViewController: OnBoardingViewDelegate {
    func startButtonTapped() {
        let setNicknameVC = SetNicknameViewController()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(setNicknameVC, animated: true)
    }
}
