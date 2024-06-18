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

    @UserDefault(key: "searchWordList", reset: false)
    static var searchWordList: [String]?

    @UserDefault(key: "searchWordList", reset: true)
    static var resetSearchWordList: [String]?

    @UserDefault(key: "isLikeList", reset: false)
    static var isLikeList: [String]?

    @UserDefault(key: "isLikeList", reset: true)
    static var resetIsLikeList: [String]?

    @UserDefault(key: "joinDate", reset: false)
    static var joinDate: String?

    @UserDefault(key: "joinDate", reset: true)
    static var resetJoinDate: String?
}

extension UserDefaultManager {
    static var isLikeListCount: String {
        guard let isLikeList = UserDefaultManager.isLikeList else {
            return "0 \(Constant.LiteralString.Setting.likeCount)"
        }
        return "\(isLikeList.count)" + "\(Constant.LiteralString.Setting.likeCount)"
    }

    static func removeAll() {
        let _ = UserDefaultManager.resetImage
        let _ = UserDefaultManager.resetNickname
        let _ = UserDefaultManager.resetJoinDate
        let _ = UserDefaultManager.resetSearchWordList
        let _ = UserDefaultManager.resetIsLikeList
    }

    static func checkIsLike(productId: String) -> Bool {
        guard let isLikeList = UserDefaultManager.isLikeList else { return false }
        let array = isLikeList.filter { id in
            id == productId
        }
        if array.count == 0 {
            return false
        } else {
            return true
        }
    }

    static func likeButtonTapped(isLike: Bool, productId: String) {
        guard let isLikeList = UserDefaultManager.isLikeList else {
            UserDefaultManager.isLikeList = [productId]
            return
        }
        if isLike {
            UserDefaultManager.isLikeList?.append(productId)
        } else  {
            let array = isLikeList.filter { id in
                id != productId
            }
            UserDefaultManager.isLikeList = array
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

    static func setSearchWordList(text: String) -> [String] {
        guard UserDefaultManager.searchWordList != nil else {
            UserDefaultManager.searchWordList = [text]
            return UserDefaultManager.searchWordList ?? []
        }

        UserDefaultManager.searchWordList?.insert(text, at: 0)
        return UserDefaultManager.searchWordList ?? []
    }

    static func removeAllWord() -> [String] {
        let _ = UserDefaultManager.resetSearchWordList
        return []
    }

    static func removeWord(index: Int) -> [String] {
        guard UserDefaultManager.searchWordList != nil else { return [] }
        UserDefaultManager.searchWordList?.remove(at: index)
        return UserDefaultManager.searchWordList ?? []
    }
}
