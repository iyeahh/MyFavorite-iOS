//
//  ProfileImage.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import UIKit

final class Profile {
    let imageList: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    var state: State

    init(state: State) {
        self.state = state
    }

    func isPossible(nickname: String?) -> Bool {
        guard let nickname = nickname else { return false }
        let message = Constant.LiteralString.Nickname.possible
        guard determineNickname(input: nickname) == message else {
            return false
        }
        return true
    }

    func randomImage() -> Int {
        guard let num = imageList.randomElement() else {
            return 0
        }
        return num
    }

    func setImage() -> Int {
        guard state == .edit else {
            guard let tempImage = UserDefaultManager.tempImage else {
                return randomImage()
            }
            let _ = UserDefaultManager.resetTempImage
            return tempImage
        }
        guard let tempImage = UserDefaultManager.tempImage else {
            guard let savedImage = UserDefaultManager.image else {
                return 0
            }
            return savedImage
        }
        let _ = UserDefaultManager.resetTempImage
        return tempImage
    }

    func determineNickname(input: String?) -> String {
        var message = ""

        guard let text = input else {
            return Constant.LiteralString.Nickname.whiteSpace
        }

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

        guard numArray.isEmpty else {
            return Constant.LiteralString.Nickname.containNumber
        }

        guard text.count > 1 && text.count < 10 else {
            return Constant.LiteralString.Nickname.incorrectNumber
        }

        return Constant.LiteralString.Nickname.possible
    }
}
