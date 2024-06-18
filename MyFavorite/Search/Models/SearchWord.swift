//
//  SearchWord.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import Foundation

final class SearchWord {
    func setSearchWordList(text: String) -> [String] {
        guard UserDefaultManager.searchWordList != nil else {
            UserDefaultManager.searchWordList = [text]
            return UserDefaultManager.searchWordList ?? []
        }

        UserDefaultManager.searchWordList?.insert(text, at: 0)
        return UserDefaultManager.searchWordList ?? []
    }

    func removeAllWord() -> [String] {
        let _ = UserDefaultManager.resetSearchWordList
        return []
    }

    func removeWord(index: Int) -> [String] {
        guard UserDefaultManager.searchWordList != nil else { return [] }
        UserDefaultManager.searchWordList?.remove(at: index)
        return UserDefaultManager.searchWordList ?? []
    }
}
