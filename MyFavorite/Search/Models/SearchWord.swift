//
//  SearchWord.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import Foundation

final class SearchWord {
    func setSearchWordList(text: String) -> [String] {
        guard let searchWord = UserDefaultManager.search else {
            UserDefaultManager.search = text
            return UserDefaultManager.search?.makeArray ?? []
        }

        UserDefaultManager.search = text + " " + searchWord
        return UserDefaultManager.search?.makeArray ?? []
    }

    func removeAllWord() -> [String] {
        let _ = UserDefaultManager.resetSearch
        return []
    }

    func removeWord(index: Int) -> [String] {
        guard let searchWords = UserDefaultManager.search else { return [] }
        var array = searchWords.makeArray
        if array.count == 1 {
            let _ = UserDefaultManager.resetSearch
            return []
        }
        array.remove(at: index)
        UserDefaultManager.search = array.joined(separator: " ")
        return UserDefaultManager.search?.makeArray ?? []
    }
}
