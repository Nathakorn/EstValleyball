//
//  MenuController.swift
//  EstValleyball
//
//  Created by KORN on 6/12/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    var fromSegue: String!
   
    @IBAction func playGame(sender: UIButton) {
        self.performSegueWithIdentifier(SEGUE_SHOW_GAME, sender: nil)
    }
    @IBAction func goStartGame(sender: UIButton) {
        self.performSegueWithIdentifier(fromSegue, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(fromSegue)
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
