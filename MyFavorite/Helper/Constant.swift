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

    enum Charactor {
        case isSelected
        case unSelected

        var borderSetting: (Int, CGFloat) {
            switch self {
            case .isSelected:
                return (3, 100)
            case .unSelected:
                return (1, 50)
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

    enum LiteralString {
        enum Title {
            enum navigationBar: String {
                case profileSetting = "PROFILE SETTING"
                case editProfile = "EDIT PROFILE"
                case meaningOut = "'s MEANING OUT"
                case setting = "SETTING"
            }

            enum tabBar: String {
                case search = "검색"
                case setting = "설정"
            }

            enum button {
                static let start = "시작하기"
                static let complete = "완료"
            }
        }

        enum TextField {
            static let input = "닉네임을 입력해주세요 :)"
            static let possible = "사용할 수 있는 닉네임이에요."
            static let incorrectNumber = "2글자 이상 10글자 미만으로 설정해주세요."
            static let placeholder = "브랜드, 상품 등을 입력하세요."

            enum ContainWrongCharactor: String {
                case at = "@"
                case sharp = "#"
                case dollar = "$"
                case percent = "%"

                var message: String {
                    return "닉네임에 \(self.rawValue)는 포함할 수 없어요."
                }
            }
        }

        enum Search {
            enum SearchWord {
                static let noWord = "최근 검색어가 없어요"
                static let latest = "최근 검색"
                static let removeAll = "전체 삭제"
                static let resultNumber = "개의 검색 결과"
            }

            enum SortResult: String {
                case accuracy = "정확도"
                case date = "날짜순"
                case highPrice = "가격높은순"
                case lowPrice = "가격낮은순"
            }
        }
    }
}
