//
//  SearchViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class SearchViewController: UIViewController {
    let searchWord = SearchWord()

    private var searchWordList: [String] = UserDefaultManager.search?.makeArray ?? [] {
        didSet {
            rootView.searchWordList = searchWordList
        }
    }

    private lazy var rootView = SearchRootView(searchWordList: searchWordList)

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavi()
        rootView.searchRootViewDelegate = self
        print(searchWordList.count)
    }

    private func configureNavi() {
        guard let nickname = UserDefaultManager.nickname else { return }
        navigationItem.title = "\(nickname)" + Constant.LiteralString.Title.NavigationBar.meaningOut.rawValue
    }
}

extension SearchViewController: SearchRootViewDelegate {
    func removeWordButtonTapped(index: Int) {
        searchWordList = searchWord.removeWord(index: index)
    }
    
    func searchButtonTapped(text: String) {
        searchWordList = searchWord.setSearchWordList(text: text)
        let resultVC = ResultViewController()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(resultVC, animated: true)
    }

    func removeAllButtonTapped() {
        searchWordList = searchWord.removeAllWord()
    }
}
