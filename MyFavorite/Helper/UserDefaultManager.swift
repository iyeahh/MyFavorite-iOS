//
//  UserDefaultManager.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import Foundation

final class UserDefaultManager {
    @UserDefault(key: "image", reset: false)
    static var image: Int?

    @UserDefault(key: "image", reset: true)
    static var resetImage: Int?

    @UserDefault(key: "nickname", reset: false)
    static var nickname: String?

    @UserDefault(key: "nickname", reset: true)
    static var resetNickname: String?

}
