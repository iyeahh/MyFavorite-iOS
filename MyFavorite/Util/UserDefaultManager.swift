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

    @UserDefault(key: "search", reset: false)
    static var search: String?

    @UserDefault(key: "search", reset: true)
    static var resetSearch: String?

    @UserDefault(key: "isLike", reset: false)
    static var isLike: String?

    @UserDefault(key: "isLike", reset: true)
    static var resetIsLike: String?
}
