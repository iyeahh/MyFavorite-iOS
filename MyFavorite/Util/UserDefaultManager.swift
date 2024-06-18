//
//  UserDefaultManager.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import Foundation

final class UserDefaultManager {
    private init() { }

    @UserDefault(key: "image", reset: false)
    static var image: Int?

    @UserDefault(key: "image", reset: true)
    static var resetImage: Int?

    @UserDefault(key: "tempImage", reset: false)
    static var tempImage: Int?

    @UserDefault(key: "tempImage", reset: true)
    static var resetTempImage: Int?

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

    @UserDefault(key: "joinDate", reset: false)
    static var joinDate: String?

    @UserDefault(key: "joinDate", reset: true)
    static var resetJoinDate: String?

    static var likeCount: String {
        guard let isLikeList = UserDefaultManager.isLike else {
            return "0 \(Constant.LiteralString.Setting.likeCount)"
        }
        let array = isLikeList.makeArray
        return "\(array.count)" + "\(Constant.LiteralString.Setting.likeCount)"
    }

    static func removeAll() {
        let _ = UserDefaultManager.resetImage
        let _ = UserDefaultManager.resetNickname
        let _ = UserDefaultManager.resetJoinDate
        let _ = UserDefaultManager.resetSearch
        let _ = UserDefaultManager.resetIsLike
    }

    static func checkIsLike(productId: String) -> Bool {
        guard let isLikeString = UserDefaultManager.isLike else { return false }
        let array = isLikeString.makeArray
        let removedArray = array.filter { str in
            str == productId
        }
        if removedArray.count == 0 {
            return false
        } else {
            return true
        }
    }

    static func likeButtonTapped(isLike: Bool, productId: String) {
        if UserDefaultManager.isLike == nil {
            UserDefaultManager.isLike = productId
            return
        }

        guard let isLikeString = UserDefaultManager.isLike else { return }
        
        if isLike {
            UserDefaultManager.isLike = isLikeString + " " + productId
        } else {
            let array = isLikeString.makeArray
            if array.count == 1 {
                let _ = UserDefaultManager.resetIsLike
            } else {
                let removedArray = array.filter { str in
                    str != productId
                }
                UserDefaultManager.isLike = removedArray.joined(separator: " ")
            }
        }
    }

    static func getUserInfo() -> UserInfo? {
        guard let image = UserDefaultManager.image,
              let nickname = UserDefaultManager.nickname,
              let joinDate = UserDefaultManager.joinDate else { return nil }

        return UserInfo(image: image, nickname: nickname, joinDate: joinDate)
    }

    static func isLogined() -> Bool {
        guard UserDefaultManager.image != nil &&
              UserDefaultManager.nickname != nil else { return false }
        return true
    }
}
