//
//  SearchViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class SearchViewController: UIViewController {
    private let rootView = SearchRootView()

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavi()
    }

    private func configureNavi() {
        guard let nickname = UserDefaultManager.nickname else { return }
        navigationItem.title = "\(nickname)" + Constant.LiteralString.Title.NavigationBar.meaningOut.rawValue
    }
}
