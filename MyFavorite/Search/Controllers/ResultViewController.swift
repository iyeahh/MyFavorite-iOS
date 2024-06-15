//
//  ResultViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import UIKit

final class ResultViewController: UIViewController {
    private let rootView = SearchResultRootView()

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavi()
    }

    private func configureNavi() {
        navigationItem.title = "기계식 키보드"
    }
}
