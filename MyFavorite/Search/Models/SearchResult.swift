//
//  SearchResult.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/17/24.
//

import UIKit

final class SearchResult {
    var searchWord: String
    var isEnd = false
    var total = 0

    var totalString: String {
        total.formatted() + Constant.LiteralString.Search.SearchWord.resultNumber
    }

    init(searchWord: String) {
        self.searchWord = searchWord
    }

    func convertItemInfo(items: [Item]) -> [ItemInfo] {
        return items.map { item in
            return ItemInfo(
                title: item.title.makeOnlyString,
                link: item.link,
                image: item.image,
                price: item.lprice.makeInt ?? "",
                mallName: item.mallName,
                productId: item.productId,
                isLiked: UserDefaultManager.checkIsLike(productId: item.productId)
            )
        }
    }

    func likeButtonTapped(itemInfo: ItemInfo) {
        if UserDefaultManager.isLike == nil || UserDefaultManager.isLike == "" {
            UserDefaultManager.isLike = "빈배열아님"
        }

        guard let isLikeString = UserDefaultManager.isLike else { return }


        if itemInfo.isLiked {
            let array = isLikeString.makeArray
            let removedArray = array.filter { str in
                str != itemInfo.productId
            }
            UserDefaultManager.isLike = removedArray.joined(separator: " ")
        } else {
            UserDefaultManager.isLike = isLikeString + " " + itemInfo.productId
        }
    }
}
