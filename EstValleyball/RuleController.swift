//
//  RuleController.swift
//  EstValleyball
//
//  Created by KORN on 6/12/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class RuleController: UIViewController {

    @IBAction func goBackButton(sender: UIButton) {
        web.goBack()
    }
    @IBOutlet weak var web: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url: NSURL?
        
        if let urlString = Parameters.instance.parameters["page_rule"] {
            url = NSURL(string: urlString)
        } else {
            url = NSURL(string: "http://www.estcolathai.com/volleyballmobile/rule.html")
        }
        
        let request = NSURLRequest(URL: url!)
        web.loadRequest(request)        // Do any additional setup after loading the view.
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
