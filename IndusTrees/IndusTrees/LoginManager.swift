//
//  LoginManager.swift
//  IndusTrees
//
//  Created by Antonio Antonino on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import Foundation

class LoginManager {
    
    static let shared = LoginManager()
    
    private init() {}
    
    var userId: UInt16? {
        set {
            if let id = newValue {
                UserDefaults.standard.set(id, forKey: "id")
                UserDefaults.standard.synchronize()
            }
        }
        get {
            return UserDefaults.standard.integer(forKey: "id") as? UInt16
        }
    }
}
