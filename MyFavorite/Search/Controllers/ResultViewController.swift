//
//  ResultViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import UIKit

final class ResultViewController: UIViewController {
    var searchResult: SearchResult

    private var page = 1 {
        didSet {
            callRequest()
            if Double(searchResult.total + 30) / 30.0 < Double(page) {
                searchResult.isEnd = true
            }
        }
    }

    private var sort: ResultSort = .accuracy {
        didSet {
            rootView.sort = sort
            callRequest(reload: true)
        }
    }

    var result: [ItemInfo] = [] {
        didSet {
            rootView.items = result
        }
    }

    private let rootView = SearchResultRootView()

    init(searchResult: SearchResult) {
        self.searchResult = searchResult
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
        configureNavi()
        callRequest()
        rootView.searchResultRootViewDelegate = self
    }

    private func configureNavi() {
        navigationItem.title = "\(searchResult.searchWord)"
    }
}

extension ResultViewController {
    private func callRequest(reload: Bool = false) {
        NetworkManager.callRequest(query: searchResult.searchWord, page: page, sort: sort) { value in
            if self.searchResult.isEnd {
                return
            } else {
                let itemInfo = self.searchResult.convertItemInfo(items: value.items)
                if reload {
                    self.result = itemInfo
                } else {
                    self.result.append(contentsOf: itemInfo)
                }
            }
            self.searchResult.total = value.total
            self.rootView.total = self.searchResult.totalString
        }
    }
}

extension ResultViewController: SearchResultRootViewDelegate {
    func isLikeCallBack(index: Int) {
        let itemInfo = result[index]
        searchResult.likeButtonTapped(itemInfo: itemInfo)
        result[index].isLiked.toggle()
    }

    func nextPage() {
        page += 1
    }

    func sortButtonTapped(_ standard: ResultSort) {
        sort = standard
    }

    func selectedCell(index: Int) {
        let detailVC = DetailViewController()
        let item = result[index]
        detailVC.productId = item.productId
        detailVC.url = item.link.removeSlash
        detailVC.naviTitle = item.title
        detailVC.isLike = item.isLiked
        moveNextVC(vc: detailVC)
    }
}
