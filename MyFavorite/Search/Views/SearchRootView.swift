//
//  SearchRootView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit
import SnapKit

final class SearchRootView: UIView {
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

    private let resultImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constant.Image.Picture.empty
        return imageView
    }()

    private let resultLabel = {
        let label = UILabel()
        label.text = Constant.LiteralString.Search.SearchWord.noWord
        label.textColor = Constant.Color.primary
        label.font = Constant.Font.bold15
        return label
    }()

    private let bottomBarView = {
        let view = BarView(color: Constant.Color.secondaryLightGray)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureHierarchy()
        configureLayout()
        resultImageView.isHidden = true
        resultLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchRootView {
    private func configureUI() {
        backgroundColor = Constant.Color.secondary
    }

    private func configureHierarchy() {
        addSubview(searchBar)
        addSubview(topBarView)
        addSubview(resultImageView)
        addSubview(resultLabel)
        addSubview(bottomBarView)
    }

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

        resultImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(resultImageView.snp.width)
        }

        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resultImageView.snp.bottom).offset(10)
        }

        bottomBarView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
    }
}
