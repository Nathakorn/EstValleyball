//
//  Parameters.swift
//  EstValleyball
//
//  Created by KORN on 6/17/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import Foundation

class Parameters: NSObject {
    
    /*
    class var instance: Parameters {
        struct Static {
            static let instance: Parameters = Parameters()
        }
        return Static.instance
    }
    */
    
    static let instance: Parameters = Parameters()
    
    private override init() {
        self.parameters = [String : String]()
    }
    
    var parameters: [String : String]!
    
}