//
//  BaseCollectionViewCell.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/26/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarchy() { }
    func configureLayout() { }
}
