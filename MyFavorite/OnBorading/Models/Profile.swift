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

    func validUserInput(input: String?) throws -> Void {
        guard let text = input else {
            throw NicknameError.whiteSpace
        }

        guard !text.isEmpty && !text.contains(" ") else {
            throw NicknameError.whiteSpace
        }

        try Constant.LiteralString.Nickname.ContainWrongCharactor.allCases.forEach { character in
            guard !text.contains(character.rawValue) else {
                throw NicknameError.containSymbol
            }
        }

        let numArray = text.filter { character in
            character.isNumber
        }

        guard numArray.isEmpty else {
            throw NicknameError.containNumber
        }

        guard text.count > 1 && text.count < 10 else {
            throw NicknameError.incorrectNumber
        }
    }

    func determineNickname(input: String?) -> String {
        do {
            try validUserInput(input: input)
            return Constant.LiteralString.Nickname.possible
        } catch NicknameError.containNumber {
            return Constant.LiteralString.Nickname.containNumber
        } catch NicknameError.containSymbol {
            return Constant.LiteralString.Nickname.containSymbol
        } catch NicknameError.incorrectNumber {
            return Constant.LiteralString.Nickname.incorrectNumber
        } catch NicknameError.whiteSpace {
            return Constant.LiteralString.Nickname.whiteSpace
        } catch {
            return "닉네임 양식에 맞지 않음"
        }
    }
}
