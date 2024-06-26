//
//  SettingTableViewCell.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/17/24.
//

import UIKit
import SnapKit

final class SettingTableViewCell: BaseTableViewCell {
    private let settingLabel = {
        let label = UILabel()
        label.textColor = Constant.Color.primary
        label.font = Constant.Font.system15
        return label
    }()

    private let likeImageView = {
        let imageView = UIImageView()
        imageView.image = Constant.Image.Icon.likeSelected
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let likeCountLabel = {
        let label = UILabel()
        label.textColor = Constant.Color.primary
        label.font = Constant.Font.system15
        return label
    }()

    override func configureHierarchy() {
        contentView.addSubview(settingLabel)
        contentView.addSubview(likeImageView)
        contentView.addSubview(likeCountLabel)
    }

    override func configureLayout() {
        settingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        likeCountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        likeImageView.snp.makeConstraints { make in
            make.trailing.equalTo(likeCountLabel.snp.leading)
            make.centerY.equalToSuperview()
            make.height.equalTo(likeCountLabel.snp.height)
            make.width.equalTo(likeImageView.snp.height)
        }
    }
}

extension SettingTableViewCell {
    func setData(index: Int, count: String?, text: String) {
        settingLabel.text = text

        if index == 0 {
            likeCountLabel.text = count
            likeCountLabel.isHidden = false
            likeImageView.isHidden = false
        } else {
            likeCountLabel.isHidden = true
            likeImageView.isHidden = true
        }
    }
}
