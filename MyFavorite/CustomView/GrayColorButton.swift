//
//  GrayColorButton.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import UIKit

final class GrayColorButton: UIButton {
    var isTapped: Bool {
        didSet {
            isTappedButtonConfiguration()
        }
    }

    init(isTapped: Bool, title: String) {
        self.isTapped = isTapped
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = Constant.Font.system15
        layer.masksToBounds = true
        layer.cornerRadius = Constant.LiteralNum.cornerRadius15
        layer.borderWidth = Constant.LiteralNum.borderWidth1
        layer.borderColor = Constant.Color.secondaryGray.cgColor
        isTappedButtonConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func isTappedButtonConfiguration() {
        if isTapped {
            setTitleColor(Constant.Color.secondary, for: .normal)
            backgroundColor = Constant.Color.secondaryDarkGray
        } else {
            setTitleColor(Constant.Color.primary, for: .normal)
            backgroundColor = Constant.Color.secondary
        }
    }
}
