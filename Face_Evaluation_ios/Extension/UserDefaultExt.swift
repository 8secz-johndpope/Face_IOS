//
//  UserDefaultExt.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 21/10/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation

extension UserDefaults {
    func getValue<T>(_ key: String) -> T? {
        if UserDefaults.isNativelySupportedType(T.self) {
            return object(forKey: key) as? T ?? nil
        }
        
        return nil
    }
    
    fileprivate func _encode<T: Codable>(_ value: T) -> String? {
        do {
            let data = try JSONEncoder().encode([value])
            return String(String(data: data, encoding: .utf8)!.dropFirst().dropLast())
        } catch {
            print(error)
            return nil
        }
    }
    
    func setValue<T>(_ key: String, to value: T) {
        if UserDefaults.isNativelySupportedType(T.self) {
            set(value, forKey: key)
            return
        }
    }
    
    fileprivate static func isNativelySupportedType<T>(_ type: T.Type) -> Bool {
        switch type {
        case is Bool.Type,
             is String.Type,
             is Int.Type,
             is Double.Type,
             is Float.Type,
             is Date.Type,
             is Data.Type:
            return true
        default:
            return false
        }
    }
}

