//
//  GrayColorButton.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import UIKit

final class GrayColorButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(Constant.Color.primary, for: .normal)
        setTitleColor(Constant.Color.secondary, for: .selected)
        titleLabel?.font = Constant.Font.system15
        layer.masksToBounds = true
        layer.cornerRadius = Constant.LiteralNum.cornerRadius20
        layer.borderWidth = Constant.LiteralNum.borderWidth1
        layer.borderColor = Constant.Color.secondaryGray.cgColor
        backgroundColor = currentTitleColor == Constant.Color.secondary ? Constant.Color.secondaryDarkGray : Constant.Color.secondary
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
