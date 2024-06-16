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

    var makeInt: String? {
        guard let intString = Int(self) else { return nil }
        return "\(intString.formatted())"
    }

    var makeOnlyString: String {
        let str = self.replacingOccurrences(of: "<b>", with: "")
        return str.replacingOccurrences(of: "</b>", with: "")
    }

    var removeSlash: String {
        return self.replacingOccurrences(of: #"\"#, with: "")
    }
}
