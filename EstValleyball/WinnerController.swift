//
//  WinnerController.swift
//  EstValleyball
//
//  Created by KORN on 6/12/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class WinnerController: UIViewController {

    @IBOutlet weak var winnerView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url: NSURL?
        
        if let urlString = Parameters.instance.parameters["page_winner"] {
            url = NSURL(string: urlString)
        } else {
            url = NSURL(string: "http://www.estcolathai.com/volleyballmobile/winner.aspx")
        }

        let request = NSURLRequest(URL: url!)
        winnerView.loadRequest(request)
        // Do any additional setup after loading the view.
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
