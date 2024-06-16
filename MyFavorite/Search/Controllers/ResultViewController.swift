//
//  ResultViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import UIKit

final class ResultViewController: UIViewController {
    var searchWord: String = ""
    var isEnd = false
    var page = 1 {
        didSet {
            callRequest()
            if Double(total + 30) / 30.0 < Double(page) {
                isEnd = true
            }
        }
    }
    var sort: ResultSort = .accuracy {
        didSet {
            rootView.sort = sort
            callRequest(reload: true)
        }
    }
    var total: Int = 0 {
        didSet {
            rootView.total = total.formatted() + Constant.LiteralString.Search.SearchWord.resultNumber
        }
    }
    var result: [Item] = [] {
        didSet {
            rootView.items = result
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
        callRequest()
        rootView.searchResultRootViewDelegate = self
    }

    private func configureNavi() {
        navigationItem.title = "\(searchWord)"
    }

    func callRequest(reload: Bool = false) {
        NetworkManager.callRequest(query: searchWord, page: page, sort: sort) { value in
            if self.isEnd {
                return
            } else {
                guard let resultIems = value.items else { return }
                if reload {
                    self.result = resultIems
                } else {
                    self.result.append(contentsOf: resultIems)
                }
            }

            guard let total = value.total else { return }
            self.total = total
        }
    }
}

extension ResultViewController: SearchResultRootViewDelegate {
    func nextPage() {
        page += 1
    }

    func sortButtonTapped(_ standard: ResultSort) {
        sort = standard
    }
}
