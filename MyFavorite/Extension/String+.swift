//
//  String+.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import Foundation

extension String {
    func determineNickname() -> String {
        let text = self

        var message = "m"

        guard !text.isEmpty && !text.contains(" ") else {
            return Constant.LiteralString.Nickname.whiteSpace
        }

        Constant.LiteralString.Nickname.ContainWrongCharactor.allCases.forEach { character in
            guard !text.contains(character.rawValue) else {
                message = character.message
                return
            }
        }

        guard message.count < 2 else {
            return message
        }

        let numArray = text.filter { character in
            character.isNumber
        }

        guard text.count > 1 && text.count < 10 else {
            return Constant.LiteralString.Nickname.incorrectNumber
        }

        guard numArray.isEmpty else {
            return Constant.LiteralString.Nickname.containNumber
        }

        return Constant.LiteralString.Nickname.possible
    }
}
