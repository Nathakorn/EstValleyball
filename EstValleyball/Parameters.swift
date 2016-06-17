//
//  Parameters.swift
//  EstValleyball
//
//  Created by KORN on 6/17/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import Foundation

class Parameters: NSObject {
    
    class var instance: Parameters {
        struct Static {
            static let instance: Parameters = Parameters()
        }
        return Static.instance
    }
    
    var parameters = [ String : String ]()
    
}