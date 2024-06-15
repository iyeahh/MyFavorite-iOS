//
//  String+.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import Foundation

extension String {
    var makeArray: [String] {
        return self.components(separatedBy: " ")
    }
}
