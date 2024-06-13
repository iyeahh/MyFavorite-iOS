//
//  UIImage+.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/13/24.
//

import UIKit

extension UIImage {
    func getCharactorImage(_ num: Int) -> UIImage? {
        return UIImage(named: "profile_\(num)")
    }
}
