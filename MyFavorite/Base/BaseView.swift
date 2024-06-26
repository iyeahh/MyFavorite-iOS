//
//  BaseView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/26/24.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constant.Color.secondary
        configureHierarchy()
        configureLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarchy() { }
    func configureLayout() { }
}
