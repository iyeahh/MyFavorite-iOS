//
//  SearchResultRootView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import UIKit
import SnapKit

final class SearchResultRootView: UIView {
    var total: Int? = 0 {
        didSet {
            guard let totalString = total else { return }
            resultCountLabel.text = totalString.formatted() + Constant.LiteralString.Search.SearchWord.resultNumber
        }
    }
    var items: [Item]? = [] {
        didSet {
            resultCollectionView.reloadData()
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
        let button = GrayColorButton(title: Constant.LiteralString.Search.SortResult.accuracy.rawValue)
        return button
    }()

    private let dateSortButton = {
        let button = GrayColorButton(title: Constant.LiteralString.Search.SortResult.date.rawValue)
        return button
    }()

    private let highPriceSortButton = {
        let button = GrayColorButton(title: Constant.LiteralString.Search.SortResult.highPrice.rawValue)
        return button
    }()

    private let lowPriceSortButton = {
        let button = GrayColorButton(title: Constant.LiteralString.Search.SortResult.lowPrice.rawValue)
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureHierarchy()
        configureLayout()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchResultRootView {
    private func configureUI() {
        backgroundColor = Constant.Color.secondary
    }

    private func configureHierarchy() {
        addSubview(topBarView)
        addSubview(resultCountLabel)
        addSubview(accuracySortButton)
        addSubview(dateSortButton)
        addSubview(highPriceSortButton)
        addSubview(lowPriceSortButton)
        addSubview(resultCollectionView)
        addSubview(bottomBarView)
    }

    private func configureLayout() {
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
            make.bottom.equalToSuperview().inset(1)
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
        resultCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
}

extension SearchResultRootView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = items else { return 0 }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as? SearchResultCollectionViewCell,
              let item = items?[indexPath.item]
        else {
            return UICollectionViewCell()
        }
        cell.setData(item)
        return cell
    }
}
