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
    
    
    var playButton = UIButton()
    var ruleButton = UIButton()
    var youtubeButton = UIButton()
    var winnerButton = UIButton()
    var shareButton = UIButton()
    var howToPlayButton = UIButton()
    
    var closeButton = UIButton()
   
    func playGame() {
        self.performSegueWithIdentifier(SEGUE_SHOW_GAME, sender: nil)
    }
    func goRule() {
    }
    func goHowToPlay() {
    }
    func goYoutubeButton() {
    }
    func goWinner() {
    }
    func goShare() {
    }
    func goStartGame() {
        self.performSegueWithIdentifier(fromSegue, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if fromSegue == nil{
            fromSegue = SEGUE_STARTED_GAME
        }
        //print(fromSegue)
        // Do any additional setup after loading the view.
        
        var screenSize = UIScreen.mainScreen().bounds.size
        
        var x: CGFloat = 34.0 / 320.0 * screenSize.width
        var width: CGFloat = 252.0 / 320.0 * screenSize.width
        var height: CGFloat = 23.0 / 568.0 * screenSize.height
        
        self.playButton.frame = CGRectMake(x, 82.0 / 568.0 * screenSize.height, width, height)
        self.playButton.setImage(UIImage(named: "btn_menu1.png"), forState: .Normal)
        self.playButton.setImage(UIImage(named: "btn_menu1_active.png"), forState: .Highlighted)
        self.playButton.addTarget(self, action: #selector(MenuController.playGame), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.ruleButton.frame = CGRectMake(x, 134.0 / 568.0 * screenSize.height, width, height)
        self.ruleButton.setImage(UIImage(named: "btn_menu2.png"), forState: .Normal)
        self.ruleButton.setImage(UIImage(named: "btn_menu2_active.png"), forState: .Highlighted)
        self.ruleButton.addTarget(self, action: #selector(MenuController.goRule), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.howToPlayButton.frame = CGRectMake(x, 188.0 / 568.0 * screenSize.height, width, height)
        self.howToPlayButton.setImage(UIImage(named: "btn_menu3.png"), forState: .Normal)
        self.howToPlayButton.setImage(UIImage(named: "btn_menu3_active.png"), forState: .Highlighted)
        self.howToPlayButton.addTarget(self, action: #selector(MenuController.goHowToPlay), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.youtubeButton.frame = CGRectMake(x, 237.0 / 568.0 * screenSize.height, width, height)
        self.youtubeButton.setImage(UIImage(named: "btn_menu4.png"), forState: .Normal)
        self.youtubeButton.setImage(UIImage(named: "btn_menu4_active.png"), forState: .Highlighted)
        self.youtubeButton.addTarget(self, action: #selector(MenuController.goYoutubeButton), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.winnerButton.frame = CGRectMake(x, 285.0 / 568.0 * screenSize.height, width, height)
        self.winnerButton.setImage(UIImage(named: "btn_menu5.png"), forState: .Normal)
        self.winnerButton.setImage(UIImage(named: "btn_menu5_active.png"), forState: .Highlighted)
        self.winnerButton.addTarget(self, action: #selector(MenuController.goWinner), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.shareButton.frame = CGRectMake(x, 335.0 / 568.0 * screenSize.height, width, height)
        self.shareButton.setImage(UIImage(named: "btn_menu6.png"), forState: .Normal)
        self.shareButton.setImage(UIImage(named: "btn_menu6_active.png"), forState: .Highlighted)
        self.shareButton.addTarget(self, action: #selector(MenuController.goShare), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.closeButton.frame = CGRectMake(138 / 320.0 * screenSize.width, 406.0 / 568.0 * screenSize.height, 44.0 / 320.0 * screenSize.width, 44.0 / 320.0 * screenSize.width)
        self.closeButton.setImage(UIImage(named: "btn_close.png"), forState: .Normal)
        self.closeButton.addTarget(self, action: #selector(MenuController.playGame), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.playButton)
        self.view.addSubview(self.ruleButton)
        self.view.addSubview(self.howToPlayButton)
        self.view.addSubview(self.youtubeButton)
        self.view.addSubview(self.winnerButton)
        self.view.addSubview(self.shareButton)
        self.view.addSubview(self.closeButton)
        
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
