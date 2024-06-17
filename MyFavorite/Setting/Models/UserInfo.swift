//
//  UserInfo.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/17/24.
//

import UIKit

struct UserInfo {
    var image = 0
    var nickname = ""
    var joinDate = ""

    func makeAelrt(confirmButtonTapped: (() -> Void)?) -> UIAlertController {
        let alert = UIAlertController(
            title: Constant.LiteralString.Alert.Title.alert.rawValue,
            message: Constant.LiteralString.Alert.message,
            preferredStyle: .alert)

        let confirm = UIAlertAction(
            title: Constant.LiteralString.Alert.Title.confirm.rawValue,
            style: .default,
            handler: { _ in
                confirmButtonTapped?()
            })

        let cancel = UIAlertAction(
            title: Constant.LiteralString.Alert.Title.cancel.rawValue,
            style: .cancel,
            handler: nil)

        alert.addAction(cancel)
        alert.addAction(confirm)

        return alert
    }
}
