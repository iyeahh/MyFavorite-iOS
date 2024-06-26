//
//  SelectImageCollectionViewCell.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit
import SnapKit

final class SelectImageCollectionViewCell: BaseCollectionViewCell {
    private let profileImageView = {
        let value = Constant.Charactor.unSelected.borderSetting
        let imageView = ProfileImageView(borderColor: Constant.Color.secondaryLightGray, borderWidth: value.borderWidth)
        imageView.alpha = value.alpha
        return imageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }

    override func configureHierarchy() {
        contentView.addSubview(profileImageView)
    }

    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(profileImageView.snp.width)
        }
    }
}

extension SelectImageCollectionViewCell {
    func configureIsSelectedBorder() {
        let value = Constant.Charactor.isSelected.borderSetting
        profileImageView.layer.borderColor = Constant.Color.accent.cgColor
        profileImageView.layer.borderWidth = value.borderWidth
        profileImageView.alpha = value.alpha
    }

    func configureUnSelectedBorder() {
        let value = Constant.Charactor.unSelected.borderSetting
        profileImageView.layer.borderColor = Constant.Color.secondaryLightGray.cgColor
        profileImageView.layer.borderWidth = value.borderWidth
        profileImageView.alpha = value.alpha
    }

    func configureImage(_ image: Int) {
        profileImageView.image = UIImage.getProfileImage(image)
    }
}
