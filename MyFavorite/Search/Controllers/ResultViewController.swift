//
//  ResultViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import UIKit

final class ResultViewController: UIViewController {
    var searchWord: String = ""
    private var isEnd = false
    private var page = 1 {
        didSet {
            callRequest()
            if Double(total + 30) / 30.0 < Double(page) {
                isEnd = true
            }
        }
    }
    private var sort: ResultSort = .accuracy {
        didSet {
            rootView.sort = sort
            callRequest(reload: true)
        }
    }
    private var total: Int = 0 {
        didSet {
            rootView.total = total.formatted() + Constant.LiteralString.Search.SearchWord.resultNumber
        }
    }
    var result: [ItemInfo] = [] {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }

    private func configureNavi() {
        navigationItem.title = "\(searchWord)"
    }
}

extension ResultViewController {
    private func callRequest(reload: Bool = false) {
        NetworkManager.callRequest(query: searchWord, page: page, sort: sort) { value in
            if self.isEnd {
                return
            } else {
                let itemInfo = self.convertItemInfo(items: value.items)
                if reload {
                    self.result = itemInfo
                } else {
                    self.result.append(contentsOf: itemInfo)
                }
            }

            self.total = value.total
        }
    }

    private func convertItemInfo(items: [Item]) -> [ItemInfo] {
        return items.map { item in
            return ItemInfo(
                title: item.title.makeOnlyString,
                link: item.link,
                image: item.image,
                price: item.lprice.makeInt ?? "",
                mallName: item.mallName,
                productId: item.productId,
                isLiked: self.checkIsLike(productId: item.productId)
            )
        }
    }
}

extension ResultViewController: SearchResultRootViewDelegate {
    private func checkIsLike(productId: String) -> Bool {
        guard let isLikeString = UserDefaultManager.isLike else { return false }
        let array = isLikeString.makeArray
        let removedArray = array.filter { str in
            str == productId
        }
        if removedArray.count == 0 {
            return false
        } else {
            return true
        }
    }

    func isLikeCallBack(index: Int) {
        if UserDefaultManager.isLike == nil || UserDefaultManager.isLike == "" {
            UserDefaultManager.isLike = "빈배열아님"
        }

        guard let isLikeString = UserDefaultManager.isLike else { return }

        if result[index].isLiked {
            let array = isLikeString.makeArray
            let removedArray = array.filter { str in
                str != result[index].productId
            }
            UserDefaultManager.isLike = removedArray.joined(separator: " ")
        } else {
            UserDefaultManager.isLike = isLikeString + " " + result[index].productId
        }

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
