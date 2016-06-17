//
//  EstValleyballHTTPService.swift
//  EstValleyball
//
//  Created by KORN on 6/17/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import Foundation

enum GoogleAnalyticsCategory: String {
    case Page = "Page"
    case Button = "Button"
}

enum GoogleAnalyticsAction: String {
    case Opened = "opened"
    case Clicked = "clicked"
}

class EstValleyballHTTPService {
    
    class var instance: EstValleyballHTTPService {
        struct Static {
            static let instance: EstValleyballHTTPService = EstValleyballHTTPService()
        }
        return Static.instance
    }
    
    func sendGoogleAnalyticsEventTracking(category: GoogleAnalyticsCategory, action: GoogleAnalyticsAction, label: String) {
        let builder = GAIDictionaryBuilder.createEventWithCategory(
                category.rawValue,
                action: action.rawValue,
                label: label,
                value: nil)
        
        let tracker: GAITracker = GAI.sharedInstance().trackerWithTrackingId("UA-66731261-9")
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
}
