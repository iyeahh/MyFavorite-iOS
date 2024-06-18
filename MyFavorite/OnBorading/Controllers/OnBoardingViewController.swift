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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension OnBoardingViewController: OnBoardingViewDelegate {
    func startButtonTapped() {
        let setNicknameVC = SetNicknameViewController(state: .create)
        moveNextVC(vc: setNicknameVC)
    }
}
