//
//  Date+.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/17/24.
//

import Foundation

extension Date {
    static var dateString: String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        return dateFormatter.string(from: nowDate)
    }
}
