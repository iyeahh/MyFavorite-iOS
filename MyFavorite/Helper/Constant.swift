//
//  Constant.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/13/24.
//

import UIKit

enum Constant {
    enum Color {
        static let accent = UIColor(hex: 0xEF8947)
        static let primary = UIColor(hex: 0x000000)
        static let secondary = UIColor(hex: 0xFFFFFF)
        static let secondaryDarkGray = UIColor(hex: 0x4C4C4C)
        static let secondaryGray = UIColor(hex: 0x828282)
        static let secondaryLightGray = UIColor(hex: 0xCDCDCD)
    }

    enum Font {
        static let title = UIFont(name: "Optima-ExtraBlack", size: 40)
        static let nickname = UIFont.systemFont(ofSize: 19, weight: .black)
        static let bold16 = UIFont.boldSystemFont(ofSize: 16)
        static let bold15 = UIFont.boldSystemFont(ofSize: 15)
        static let bold14 = UIFont.boldSystemFont(ofSize: 14)
        static let system15 = UIFont.systemFont(ofSize: 15)
        static let system14 = UIFont.systemFont(ofSize: 14)
        static let system13 = UIFont.systemFont(ofSize: 13)
    }

    enum Charactor {
        case isSelected
        case unSelected

        var borderSetting: (borderWidth: CGFloat, alpha: CGFloat) {
            switch self {
            case .isSelected:
                return (3, 1)
            case .unSelected:
                return (1, 0.5)
            }
        }
    }

    enum Image {
        enum Picture {
            static let main = UIImage(named: "launch")
            static let empty = UIImage(named: "empty")
        }

        enum Icon {
            static let search = UIImage(systemName: "magnifyingglass")
            static let setting = UIImage(systemName: "person")
            static let arrow = UIImage(systemName: "chevron.right")
            static let clock = UIImage(systemName: "clock")
            static let xmark = UIImage(systemName: "xmark")
            static let camera = UIImage(systemName: "camera.fill")
            static let likeSelected = UIImage(named: "like_selected")
            static let likeUnselected = UIImage(named: "like_unselected")
        }
    }

    enum LiteralNum {
        static let borderWidth5: CGFloat = 5
        static let borderWidth1: CGFloat = 1
        static let cornerRadius20: CGFloat = 20
        static let cornerRadius15: CGFloat = 15
        static let cornerRadius10: CGFloat = 10
        static let display = 30
        static let backgroundAlpha: CGFloat = 0.5
    }

    enum LiteralString {
        enum Title {
            static let service = "MyFavorite"

            enum NavigationBar: String {
                case meaningOut = "'s MEANING OUT"
                case setting = "SETTING"
            }

            enum TabBar: String {
                case search = "검색"
                case setting = "설정"
            }

            enum Button {
                static let start = "시작하기"
                static let complete = "완료"
                static let save = "저장"
            }
        }

        enum Nickname {
            static let placeholer = "닉네임을 입력해주세요 :)"
            static let possible = "사용할 수 있는 닉네임이에요."
            static let incorrectNumber = "2글자 이상 10글자 미만으로 설정해주세요."
            static let containNumber = "닉네임에 숫자는 포함할 수 없어요."
            static let whiteSpace = "닉네임에 공백은 포함할 수 없어요."
            static let containSymbol = "닉네임에 @, #, $, %는 포함할 수 없어요."

            enum ContainWrongCharactor: String, CaseIterable {
                case at = "@"
                case sharp = "#"
                case dollar = "$"
                case percent = "%"
            }
        }

        enum Search {
            static let placeholder = "브랜드, 상품 등을 입력하세요."

            enum SearchWord {
                static let noWord = "최근 검색어가 없어요"
                static let latest = "최근 검색"
                static let removeAll = "전체 삭제"
                static let resultNumber = "개의 검색 결과"
            }
        }

        enum Networking {
            static let clientID = "X-Naver-Client-Id"
            static let clientSceret = "X-Naver-Client-Secret"

            enum param: String {
                case query
                case start
                case display
                case sort
            }
        }

        enum Setting: String {
            static let likeCount = "개의 상품"

            case shoppingList = "나의 장바구니 목록"
            case question = "자주 묻는 질문"
            case inquiry = "1:1 문의"
            case alarm = "알림 설정"
            case cancelMembership = "탈퇴하기"
        }

        enum Alert {
            static let message = "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?"

            enum Title: String {
                case alert = "탈퇴하기"
                case confirm = "확인"
                case cancel = "취소"
            }
        }
    }
}
