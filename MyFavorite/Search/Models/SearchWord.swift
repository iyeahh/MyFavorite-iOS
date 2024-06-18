//
//  SearchWord.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/15/24.
//

import Foundation

final class SearchWord {
    func setSearchWordList(text: String) -> [String] {
        guard UserDefaultManager.search != nil else {
            UserDefaultManager.search = [text]
            return UserDefaultManager.search ?? []
        }

        UserDefaultManager.search?.insert(text, at: 0)
        return UserDefaultManager.search ?? []
    }

    func removeAllWord() -> [String] {
        let _ = UserDefaultManager.resetSearch
        return []
    }

    func removeWord(index: Int) -> [String] {
        guard UserDefaultManager.search != nil else { return [] }
        UserDefaultManager.search?.remove(at: index)
        return UserDefaultManager.search ?? []
    }
}
