//
//  UserDefualt.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/14/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let reset: Bool
    let storage: UserDefaults = UserDefaults.standard

    var wrappedValue: T? {
        get {
            if reset {
                self.storage.removeObject(forKey: key)
                return self.storage.object(forKey: key) as? T
            } else {
                return self.storage.object(forKey: key) as? T
            }
        }

        set {
            self.storage.set(newValue, forKey: self.key)
        }
    }
}

