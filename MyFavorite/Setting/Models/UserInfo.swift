//
//  UserInfo.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/17/24.
//

import Foundation

struct UserInfo {
    var image = 0
    var nickname = ""
    var joinDate = ""

    var likeCount: String {
        guard let isLikeList = UserDefaultManager.isLike else { return "0" }
        var array = isLikeList.makeArray
        return "\(array.count)" + "\(Constant.LiteralString.Setting.likeCount)"
    }
}
