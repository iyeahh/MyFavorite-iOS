//
//  SearchWordTableViewCell.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit
import SnapKit

final class SearchWordTableViewCell: BaseTableViewCell {
    var removeCallBack: (() -> Void)?

    private let iconImageView = {
        let imageView = UIImageView()
        imageView.image = Constant.Image.Icon.clock
        imageView.tintColor = Constant.Color.primary
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let searchWordLabel = {
        let label = UILabel()
        label.font = Constant.Font.system13
        label.textColor = Constant.Color.primary
        return label
    }()

    private let removeWordButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(Constant.Image.Icon.xmark, for: .normal)
        button.tintColor = Constant.Color.primary
        button.addTarget(nil, action: #selector(removeWordButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func removeWordButtonTapped(searchWordIndex: Int) {
        removeCallBack?()
    }

    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(removeWordButton)
        contentView.addSubview(searchWordLabel)
    }

    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(10)
            make.width.equalTo(iconImageView.snp.height)
        }

        removeWordButton.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(10)
            make.width.equalTo(removeWordButton.snp.height)
        }

        searchWordLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.trailing.equalTo(removeWordButton.snp.leading).inset(20)
            make.centerY.equalToSuperview()
        }
    }

    func setSearchWord(_ data: String) {
        searchWordLabel.text = data
    }
}
