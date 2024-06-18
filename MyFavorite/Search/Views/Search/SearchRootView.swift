//
//  SearchRootView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit
import SnapKit

protocol SearchRootViewDelegate: AnyObject {
    func searchButtonTapped(text: String)
    func removeAllButtonTapped()
    func removeWordButtonTapped(index: Int)
    func selectCell(index: Int)
}

final class SearchRootView: UIView {
    var searchWordList: [String] = [] {
        didSet {
            if searchWordList == [] {
                print("비어있잖니")
                isEmptyWord(true)
                searchWordTableView.reloadData()
                return
            }
            isEmptyWord(false)
            searchWordTableView.reloadData()
            return
        }
    }

    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Constant.LiteralString.Search.placeholder
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    private let topBarView = {
        let view = BarView(color: Constant.Color.secondaryLightGray)
        return view
    }()

    private let emptyWordImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constant.Image.Picture.empty
        return imageView
    }()

    private let emptyWordLabel = {
        let label = UILabel()
        label.text = Constant.LiteralString.Search.SearchWord.noWord
        label.textColor = Constant.Color.primary
        label.font = Constant.Font.bold15
        return label
    }()

    private let resultLabel = {
        let label = UILabel()
        label.text = Constant.LiteralString.Search.SearchWord.latest
        label.font = Constant.Font.bold14
        label.textColor = Constant.Color.primary
        return label
    }()

    private let removeAllButton = {
        let button = UIButton()
        button.setTitle(Constant.LiteralString.Search.SearchWord.removeAll, for: .normal)
        button.setTitleColor(Constant.Color.accent, for: .normal)
        button.titleLabel?.font = Constant.Font.system13
        button.addTarget(nil, action: #selector(removeAllButtonTapped), for: .touchUpInside)
        return button
    }()

    private let searchWordTableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()

    private let bottomBarView = {
        let view = BarView(color: Constant.Color.secondaryLightGray)
        return view
    }()

    weak var searchRootViewDelegate: SearchRootViewDelegate?

    init(searchWordList: [String]) {
        self.searchWordList = searchWordList
        super.init(frame: .zero)

        configureHierarchy()
        emptyWordConfigureHierarchy()
        searchWordConfigureHierarchy()

        configureLayout()
        emptyWordCconfigureLayout()
        searchWordConfigureLayout()

        configureUI()
        configureTableView()
        configureSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func removeAllButtonTapped() {
        searchRootViewDelegate?.removeAllButtonTapped()
    }
}

extension SearchRootView {
    private func configureHierarchy() {
        addSubview(searchBar)
        addSubview(topBarView)
        addSubview(bottomBarView)
    }

    private func emptyWordConfigureHierarchy() {
        addSubview(emptyWordImageView)
        addSubview(emptyWordLabel)
    }

    private func searchWordConfigureHierarchy() {
        addSubview(resultLabel)
        addSubview(removeAllButton)
        addSubview(searchWordTableView)
    }
}

extension SearchRootView {
    private func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.top.equalTo(safeAreaLayoutGuide)
        }

        topBarView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.height.equalTo(1)
        }

        bottomBarView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
    }

    private func emptyWordCconfigureLayout() {
        emptyWordImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(emptyWordImageView.snp.width)
        }

        emptyWordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyWordImageView.snp.bottom).offset(10)
        }
    }

    private func searchWordConfigureLayout() {
        removeAllButton.snp.makeConstraints { make in
            make.top.equalTo(topBarView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }

        resultLabel.snp.makeConstraints { make in
            make.centerY.equalTo(removeAllButton.snp.centerY)
            make.leading.equalToSuperview().offset(10)
        }

        searchWordTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(1)
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
        }
    }
}

extension SearchRootView {
    private func configureUI() {
        backgroundColor = Constant.Color.secondary
        if UserDefaultManager.search == nil {
            isEmptyWord(true)
        } else {
            isEmptyWord(false)
        }
    }

    private func configureTableView() {
        searchWordTableView.delegate = self
        searchWordTableView.dataSource = self
        searchWordTableView.rowHeight = 40
        searchWordTableView.register(SearchWordTableViewCell.self, forCellReuseIdentifier: SearchWordTableViewCell.identifier)
    }

    private func configureSearchBar() {
        searchBar.delegate = self
    }
}

extension SearchRootView {
    func isEmptyWord(_ bool: Bool) {
        emptyWordLabel.isHidden = !bool
        emptyWordImageView.isHidden = !bool

        resultLabel.isHidden = bool
        removeAllButton.isHidden = bool
        searchWordTableView.isHidden = bool
    }
}

extension SearchRootView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchWordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTableViewCell.identifier, for: indexPath) as? SearchWordTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.removeCallBack = {
            self.searchRootViewDelegate?.removeWordButtonTapped(index: indexPath.row)
        }

        let data = searchWordList[indexPath.row]
        cell.setSearchWord(data)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchRootViewDelegate?.selectCell(index: indexPath.row)
    }
}

extension SearchRootView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchRootViewDelegate?.searchButtonTapped(text: text)
        searchBar.resignFirstResponder()
    }
}
