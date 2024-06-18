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
    var index = 0

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
}
