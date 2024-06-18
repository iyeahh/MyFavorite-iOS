//
//  SearchViewController.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class SearchViewController: UIViewController {
    private var searchWordList: [String] = UserDefaultManager.searchWordList ?? [] {
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
    }

    override func viewWillAppear(_ animated: Bool) {
        configureNavi()
    }

    private func configureNavi() {
        guard let nickname = UserDefaultManager.nickname else { return }
        navigationItem.title = "\(nickname)" + Constant.LiteralString.Title.NavigationBar.meaningOut.rawValue
    }
}

extension SearchViewController: SearchRootViewDelegate {
    func removeWordButtonTapped(index: Int) {
        searchWordList = UserDefaultManager.removeWord(index: index)
    }
    
    func searchButtonTapped(text: String) {
        searchWordList = UserDefaultManager.setSearchWordList(text: text)
        searchWord(text: text)
    }

    func selectCell(index: Int) {
        let text = searchWordList[index]
        searchWord(text: text)
    }

    func searchWord(text: String) {
        let searchResult = SearchResult(searchWord: text)
        let resultVC = ResultViewController(searchResult: searchResult)
        moveNextVC(vc: resultVC)
    }

    func removeAllButtonTapped() {
        searchWordList = UserDefaultManager.removeAllWord()
    }
}
