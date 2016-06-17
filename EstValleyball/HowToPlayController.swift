//
//  HowToPlayController.swift
//  EstValleyball
//
//  Created by KORN on 6/17/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class HowToPlayController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var url: NSURL?
        
        if let urlString = Parameters.instance.parameters["page_howto"] {
            url = NSURL(string: urlString)
        } else {
            url = NSURL(string: "http://www.estcolathai.com/volleyballmobile/howto.html")
        }

        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Page, action: .Opened, label: "How to Play Page")
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
