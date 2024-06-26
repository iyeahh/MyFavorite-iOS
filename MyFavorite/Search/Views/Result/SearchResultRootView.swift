//
//  SearchResultRootView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import UIKit
import SnapKit

protocol SearchResultRootViewDelegate: AnyObject {
    func nextPage()
    func sortButtonTapped(_ standard: ResultSort)
    func isLikeCallBack(index: Int)
    func selectedCell(index: Int)
}

final class SearchResultRootView: BaseView {
    var total: String = "" {
        didSet {
            resultCountLabel.text = total
        }
    }
    var items: [ItemInfo] = [] {
        didSet {
            resultCollectionView.reloadData()
        }
    }

    lazy var array = [accuracySortButton, dateSortButton, highPriceSortButton, lowPriceSortButton]
    var sort: ResultSort = .accuracy {
        didSet {
            let title = sort.buttonTitle
            array.forEach { button in
                if title == button.currentTitle {
                    button.isTapped = true
                } else {
                    button.isTapped = false
                }
            }
        }
    }

    private let topBarView = {
        let view = BarView(color: Constant.Color.secondaryLightGray)
        return view
    }()

    private let resultCountLabel = {
        let label = UILabel()
        label.textColor = Constant.Color.accent
        label.font = Constant.Font.bold15
        return label
    }()

    private let accuracySortButton = {
        let button = GrayColorButton(isTapped: true, title: ResultSort.accuracy.buttonTitle)
        button.addTarget(nil, action: #selector(accuracySortButtonTapped), for: .touchUpInside)
        return button
    }()

    private let dateSortButton = {
        let button = GrayColorButton(isTapped: false, title: ResultSort.date.buttonTitle)
        button.addTarget(nil, action: #selector(dateSortButtonTapped), for: .touchUpInside)
        return button
    }()

    private let highPriceSortButton = {
        let button = GrayColorButton(isTapped: false, title: ResultSort.highPrice.buttonTitle)
        button.addTarget(nil, action: #selector(highPriceSortButtonTapped), for: .touchUpInside)
        return button
    }()

    private let lowPriceSortButton = {
        let button = GrayColorButton(isTapped: false, title: ResultSort.lowPrice.buttonTitle)
        button.addTarget(nil, action: #selector(lowPriceSortButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        let width = (UIScreen.main.bounds.width - 40) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.7)
        return layout
    }

    private let bottomBarView = {
        let view = BarView(color: Constant.Color.secondaryLightGray)
        return view
    }()

    weak var searchResultRootViewDelegate: SearchResultRootViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
    }

    override func configureHierarchy() {
        addSubview(topBarView)
        addSubview(resultCountLabel)
        addSubview(accuracySortButton)
        addSubview(dateSortButton)
        addSubview(highPriceSortButton)
        addSubview(lowPriceSortButton)
        addSubview(resultCollectionView)
        addSubview(bottomBarView)
    }

    override func configureLayout() {
        topBarView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }

        resultCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
        }

        accuracySortButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(resultCountLabel.snp.bottom).offset(10)
        }

        dateSortButton.snp.makeConstraints { make in
            make.leading.equalTo(accuracySortButton.snp.trailing).offset(5)
            make.top.equalTo(resultCountLabel.snp.bottom).offset(10)
        }

        highPriceSortButton.snp.makeConstraints { make in
            make.leading.equalTo(dateSortButton.snp.trailing).offset(5)
            make.top.equalTo(resultCountLabel.snp.bottom).offset(10)
        }

        lowPriceSortButton.snp.makeConstraints { make in
            make.leading.equalTo(highPriceSortButton.snp.trailing).offset(5)
            make.top.equalTo(resultCountLabel.snp.bottom).offset(10)
        }

        resultCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(lowPriceSortButton.snp.bottom).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(1)
        }

        bottomBarView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

extension SearchResultRootView {
    private func configureCollectionView() {
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.prefetchDataSource = self
        resultCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
}

extension SearchResultRootView {
    @objc private func accuracySortButtonTapped() {
        sortButtonTapped(.accuracy)
    }

    @objc private func dateSortButtonTapped() {
        sortButtonTapped(.date)
    }

    @objc private func highPriceSortButtonTapped() {
        sortButtonTapped(.highPrice)
    }

    @objc private func lowPriceSortButtonTapped() {
        sortButtonTapped(.lowPrice)
    }

    private func sortButtonTapped(_ standard: ResultSort) {
        searchResultRootViewDelegate?.sortButtonTapped(standard)
    }
}

extension SearchResultRootView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as? SearchResultCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.item]
        cell.isLikeCallBack = {
            self.searchResultRootViewDelegate?.isLikeCallBack(index: indexPath.item)
        }
        cell.setData(item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchResultRootViewDelegate?.selectedCell(index: indexPath.item)
    }
}

extension SearchResultRootView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if items.count - 2 == item.item {
                searchResultRootViewDelegate?.nextPage()
            }
        }
    }
}

extension SearchResultRootView {
    func updateIsLike(index: Int, isLike: Bool) {
        items[index].isLiked = isLike
        resultCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
}
