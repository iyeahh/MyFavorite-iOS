//
//  ResultSort.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/16/24.
//

import Foundation

enum ResultSort: String {
    case accuracy = "sim"
    case date = "date"
    case highPrice = "asc"
    case lowPrice = "dsc"

    var buttonTitle: String {
        switch self {
        case .accuracy:
            return "  정확도  "
        case .date:
            return "  날짜순  "
        case .highPrice:
            return "  가격높은순  "
        case .lowPrice:
            return "  가격낮은순  "
        }
    }
}
