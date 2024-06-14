//
//  AccentColorButton.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class AccentColorButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.masksToBounds = true
        layer.cornerRadius = 20
        backgroundColor = Constant.Color.accent
        titleLabel?.font = Constant.Font.bold15
        setTitleColor(Constant.Color.secondary, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

