//
//  YoutubeController.swift
//  EstValleyball
//
//  Created by KORN on 6/12/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class YoutubeController: UIViewController {
    
    var youtubeView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.mainScreen().bounds.size
        self.youtubeView.frame = CGRectMake(15/320*screenSize.width, 117/568*screenSize.height, 291/320*screenSize.width, 186/568*screenSize.height)
        
        self.view.addSubview(self.youtubeView)
        
        let url = NSURL(string: "https://www.youtube.com/watch?v=SSDvPawnuJE")
        let request = NSURLRequest(URL: url!)
        self.youtubeView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
