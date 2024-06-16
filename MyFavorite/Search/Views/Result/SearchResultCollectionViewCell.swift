//
//  SearchResultCollectionViewCell.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchResultCollectionViewCell: UICollectionViewCell {
    var isLikeCallBack: (() -> Void)?

    private let resultImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constant.LiteralNum.cornerRadius10
        return imageView
    }()

    private let isLikeBackgrounView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constant.LiteralNum.cornerRadius10
        return imageView
    }()

    private let isLikeImagaeView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Constant.Color.secondary
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constant.Image.Icon.likeSelected
        imageView.backgroundColor = .clear
        return imageView
    }()

    private let isLikeButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.addTarget(nil, action: #selector(isLikeButtonTapped), for: .touchUpInside)
        return button
    }()

    private let mallNameLabel = {
        let label = UILabel()
        label.font = Constant.Font.system13
        label.textColor = Constant.Color.secondaryLightGray
        return label
    }()

    private let resultTitleLabel = {
        let label = UILabel()
        label.font = Constant.Font.system14
        label.textColor = Constant.Color.primary
        label.numberOfLines = 2
        return label
    }()

    private let priceLabel = {
        let label = UILabel()
        label.font = Constant.Font.bold16
        label.textColor = Constant.Color.primary
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func isLikeButtonTapped() {
        isLikeCallBack?()
    }
}

extension SearchResultCollectionViewCell {
    private func configureHierarchy() {
        contentView.addSubview(resultImageView)
        contentView.addSubview(isLikeBackgrounView)
        contentView.addSubview(isLikeImagaeView)
        contentView.addSubview(isLikeButton)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(resultTitleLabel)
        contentView.addSubview(priceLabel)
    }

    private func configureLayout() {
        resultImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }

        isLikeBackgrounView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(resultImageView).inset(20)
            make.width.equalTo(resultImageView.snp.width).multipliedBy(0.17)
            make.height.equalTo(isLikeBackgrounView.snp.width)
        }

        isLikeImagaeView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(isLikeBackgrounView)
            make.width.equalTo(isLikeBackgrounView.snp.width).multipliedBy(0.7)
            make.height.equalTo(isLikeImagaeView.snp.width)
        }

        isLikeButton.snp.makeConstraints { make in
            make.edges.equalTo(isLikeBackgrounView)
        }

        mallNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.top.equalTo(resultImageView.snp.bottom).offset(5)
        }

        resultTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(mallNameLabel.snp.bottom).offset(5)
        }

        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(resultTitleLabel.snp.bottom).offset(5)
        }
    }
}

extension SearchResultCollectionViewCell {
    func setData(_ item: ItemInfo) {
//        guard let item = item else { return }
//        guard let image = item.image else { return }

        let url = URL(string: item.image)
        resultImageView.kf.setImage(with: url)
        mallNameLabel.text = item.mallName
        resultTitleLabel.text = item.title
        priceLabel.text = item.price

        if item.isLiked {
            isLikeBackgrounView.backgroundColor = Constant.Color.secondary
            isLikeImagaeView.image = Constant.Image.Icon.likeSelected
        } else {
            isLikeBackgrounView.backgroundColor = Constant.Color.primary.withAlphaComponent(Constant.LiteralNum.backgroundAlpha)
            isLikeImagaeView.image = Constant.Image.Icon.likeUnselected
        }
    }
}
