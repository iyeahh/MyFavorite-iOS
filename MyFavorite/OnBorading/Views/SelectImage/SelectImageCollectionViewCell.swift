//
//  SelectImageCollectionViewCell.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit
import SnapKit

final class SelectImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "SelectImageCollectionViewCell"

    private let profileImageView = {
        let value = Constant.Charactor.unSelected.borderSetting
        let imageView = ProfileImageView(borderColor: Constant.Color.secondaryLightGray, borderWidth: value.borderWidth)
        imageView.alpha = value.alpha
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}

extension SelectImageCollectionViewCell {
    private func configureHierarchy() {
        contentView.addSubview(profileImageView)
    }

    private func configureLayout() {
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
