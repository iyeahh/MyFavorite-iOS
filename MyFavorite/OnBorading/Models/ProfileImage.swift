//
//  ProfileImage.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

struct ProfileImage {
    static let imageList: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

    static var randomImage: Int {
        guard let num = imageList.randomElement() else {
            return 0
        }
        return num
    }
}
