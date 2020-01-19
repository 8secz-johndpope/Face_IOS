//
//  PreferencesService.swift
//  Face_Evaluation_ios
//
//  Created by leegunwook on 09/06/2019.
//  Copyright © 2019 leegunwook. All rights reserved.
//

import Foundation
import RxSwift

/// Represents the keys that are used to store user defaults
struct UserPreferences {
    private init () {}
    
    /// key for onBoarded preference
    static let onBoarded = "onBoarded"
    static let userId = "userID"
    static let token = "token"
    static let email = "email"
    static let fcmToken = "fcmToken"
}

/// This service manage the user preferences
class PreferencesService {
    func setValue<T>(_ key : String , _ value : T) {
        UserDefaults.standard.setValue(key, to: value)
    }
    
    func getValue<T : Equatable>(_ key : String , _ value : T) -> T? {
        return UserDefaults.standard.getValue(key) ?? value
    }
}

extension PreferencesService: ReactiveCompatible {}

extension Reactive where Base: PreferencesService {
    var isOnboarded: Observable<Bool> {
        return UserDefaults.standard
            .rx
            .observe(Bool.self, UserPreferences.onBoarded)
            .map { $0 ?? false }
    }
}

