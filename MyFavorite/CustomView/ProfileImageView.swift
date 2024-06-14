//
//  ProfileImageView.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class ProfileImageView: UIImageView {
    init(borderColor: UIColor, borderWidth: CGFloat) {
        super.init(frame: .zero)
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = true
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
