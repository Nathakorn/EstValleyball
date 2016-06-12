//
//  StartGameController.swift
//  EstValleyball
//
//  Created by KORN on 6/9/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class StartGameController: UIViewController {

    @IBAction func goMenu(sender: UIButton) {
        self.performSegueWithIdentifier(SEGUE_SHOW_MENU, sender: nil)
    }
    @IBOutlet weak var keepBall: UIImageView!
    var isImageBottom = true
    @IBAction func startGame(sender: UIButton) {
        self.performSegueWithIdentifier(SEGUE_STARTED_GAME, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewDidAppear(animated: Bool) {
        //var customFrame = keepBall.frame
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
                var originFrame = self.keepBall.frame
                
                originFrame.origin.y = 320.0
                
                self.keepBall.frame = originFrame
            }, completion: { finished in
        })
        /*
        UIView.animateWithDuration(1.0,
            animations: {
                
            }, completion: { finished in
                
        })
        */
        //keepBall.frame = customFrame
        //keepBall.image = UIImage(named: "07" )
        //isImageLeftSide = !isImageLeftSide
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
