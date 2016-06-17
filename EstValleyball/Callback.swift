//
//  Callback.swift
//  EstValleyball
//
//  Created by KORN on 6/17/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import Foundation

class Callback<T> {
    
    var callback: (T?, Bool, String?, NSError?) -> Void
    
    required init(callback: (T?, Bool, String?, NSError?) -> Void) {
        self.callback = callback
    }
    
}
