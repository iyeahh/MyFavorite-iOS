//
//  DetailResult.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/17/24.
//

import UIKit

final class DetailResult {
    var naviTitle: String
    var productId: String
    var url: String

    init(naviTitle: String, productId: String, url: String) {
        self.naviTitle = naviTitle
        self.productId = productId
        self.url = url
    }

    func getImage(isLike: Bool) -> UIImage? {
        if isLike {
            return Constant.Image.Icon.likeSelected?.withRenderingMode(.alwaysOriginal)
        } else {
            return Constant.Image.Icon.likeUnselected?.withRenderingMode(.alwaysOriginal)
        }
    }
}
