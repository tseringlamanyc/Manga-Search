//
//  Defaults.swift
//  Practice
//
//  Created by Tsering Lama on 1/16/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation

struct UserKey {
    static let search = "Search"
}

class UserPreference {
    private init () {}
    static let shared = UserPreference()
    
    func updateDefaults<T>(value: T, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getDefaults<T>(key: String) -> T? {
        guard let value = UserDefaults.standard.object(forKey: key) as? T else {
            return nil
        }
        return value
    }
    
}
