//
//  HomeController.swift
//  EstValleyball
//
//  Created by KORN on 6/9/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    
    @IBOutlet weak var ballView: UIImageView!
    @IBAction func loginFacebook(sender: UIButton) {
        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ballView.animationImages = [
            UIImage(named:"volleyball_001.png")!,
            UIImage(named:"volleyball_002.png")!,
            UIImage(named:"volleyball_003.png")!,
            UIImage(named:"volleyball_004.png")!,
            UIImage(named:"volleyball_005.png")!,
            UIImage(named:"volleyball_006.png")!,
            UIImage(named:"volleyball_007.png")!,
            UIImage(named:"volleyball_008.png")!,
            UIImage(named:"volleyball_009.png")!,
            UIImage(named:"volleyball_010.png")!,
            UIImage(named:"volleyball_011.png")!,
            UIImage(named:"volleyball_012.png")!,
            UIImage(named:"volleyball_013.png")!,
            UIImage(named:"volleyball_014.png")!,
            UIImage(named:"volleyball_015.png")!,
            UIImage(named:"volleyball_016.png")!,
            UIImage(named:"volleyball_017.png")!,
            UIImage(named:"volleyball_018.png")!,
            UIImage(named:"volleyball_019.png")!,
            UIImage(named:"volleyball_020.png")!,
            UIImage(named:"volleyball_021.png")!
        ]
        self.ballView.animationDuration = 0.2
        self.ballView.startAnimating()
        
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
