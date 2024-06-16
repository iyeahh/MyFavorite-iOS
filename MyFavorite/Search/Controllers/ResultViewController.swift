//
//  ResultViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import UIKit

final class ResultViewController: UIViewController {
    let model = ResultModel()
    var searchWord: String = ""
    var result: ResultEntity? {
        didSet {
            rootView.total = result?.total
            rootView.items = result?.items
        }
    }

    private let rootView = SearchResultRootView()

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavi()
        callRequest(query: searchWord)
    }

    private func configureNavi() {
        navigationItem.title = "\(searchWord)"
    }

    func callRequest(query: String) {
        let url = URLString.searchNaver + query
        NetworkManager.callRequest(url: url) { value in
            self.result = value
        }
    }
}
