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
    
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var ruleButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var winnerButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var howToPlayButton: UIButton!
    
   
    @IBAction func playGame(sender: UIButton) {
        playButton.setImage(UIImage(named: "btn_menu1_active.png"), forState: .Normal)
        self.performSegueWithIdentifier(SEGUE_SHOW_GAME, sender: nil)
    }
    @IBAction func goRule(sender: UIButton) {
        ruleButton.setImage(UIImage(named: "btn_menu2_active.png"), forState: .Normal)
    }
    @IBAction func goHowToPlay(sender: UIButton) {
        howToPlayButton.setImage(UIImage(named: "btn_menu3_active.png"), forState: .Normal)
    }
    @IBAction func goYoutubeButton(sender: UIButton) {
        youtubeButton.setImage(UIImage(named: "btn_menu4_active.png"), forState: .Normal)
    }
    @IBAction func goWinner(sender: UIButton) {
        winnerButton.setImage(UIImage(named: "btn_menu5_active.png"), forState: .Normal)
    }
    
    @IBAction func goShare(sender: UIButton) {
         shareButton.setImage(UIImage(named: "btn_menu6_active.png"), forState: .Normal)
    }
    @IBAction func goStartGame(sender: UIButton) {
        self.performSegueWithIdentifier(fromSegue, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if fromSegue == nil{
            fromSegue = SEGUE_STARTED_GAME
        }
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
