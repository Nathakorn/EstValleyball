//
//  Keychain.swift
//  EstValleyball
//
//  Created by KORN on 6/17/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import Foundation

class Keychain: NSObject {
    
    class var instance: Keychain {
        struct Static {
            static let instance: Keychain = Keychain()
        }
        return Static.instance
    }
    
}