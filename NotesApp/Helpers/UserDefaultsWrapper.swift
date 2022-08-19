//
//  UserDefaultsWrapper.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 19.08.2022.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.object(forKey: key) as? Data,
               let model = try? JSONDecoder().decode(T.self, from: data) {
                return model
            }
            
            return defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}
