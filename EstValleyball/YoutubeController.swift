//
//  YoutubeController.swift
//  EstValleyball
//
//  Created by KORN on 6/12/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit
import Alamofire
class YoutubeController: UIViewController {
    
    var youtubeView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.mainScreen().bounds.size
        self.youtubeView.frame = CGRectMake(15/320*screenSize.width, 117/568*screenSize.height, 291/320*screenSize.width, 186/568*screenSize.height)
        
        self.view.addSubview(self.youtubeView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(YoutubeController.enterFullScreen), name: UIWindowDidBecomeHiddenNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIWindowDidBecomeHiddenNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let youtubeId = Parameters.instance.parameters["youtube"] {
            let url = NSURL(string: "https://www.youtube.com/watch?v=" + youtubeId)
            let request = NSURLRequest(URL: url!)
            self.youtubeView.loadRequest(request)
        }
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Page, action: .Opened, label: "VDO Popup Page")
    }
    
    func enterFullScreen() {
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "PLAY VDO")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
