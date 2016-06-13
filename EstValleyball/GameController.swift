//
//  GameController.swift
//  EstValleyball
//
//  Created by KORN on 6/10/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var lightBling: UIImageView!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showedMenu"){
            let destination = segue.destinationViewController as! MenuController
            destination.fromSegue = SEGUE_SHOW_GAME
            //self.performSegueWithIdentifier(SEGUE_SHOW_MENU, sender: nil)
        }
    }
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    //@IBOutlet weak var comingBall: UIImageView!
    @IBOutlet weak var kmHr: UIImageView!
    @IBOutlet weak var score: UICountingLabel!
    @IBOutlet weak var spinBall: UIImageView!
    @IBOutlet weak var numCountDown: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        //number countdown
        
        self.ballFromOpponent()
        self.numCountDown.layer.zPosition = 1
        self.numCountDown.animationImages = [
            UIImage(named:"count3.png")!,
            UIImage(named:"count3f.png")!,
            UIImage(named:"count2.png")!,
            UIImage(named:"count2f.png")!,
            UIImage(named:"count1.png")!,
            UIImage(named:"count1f.png")!
        ]
        self.numCountDown.animationDuration = 3
        self.numCountDown.animationRepeatCount = 1
        self.numCountDown.startAnimating()
        
       //ball
       //NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(GameController.hitBall), userInfo: nil, repeats: false)
       //self.hitBall()
       
        
    }
    func showNoplay(){
        var noPlayPopupView = UIView()
        noPlayPopupView.frame = CGRectMake(0,0,320, 568)
        noPlayPopupView.backgroundColor = UIColor.blackColor()
        //noPlayPopupView.alpha = 0.3
        var noPlayView = UIImageView()
        let image = UIImage(named: "bg_noplay.png")
        noPlayView = UIImageView(image: image)
        noPlayView.frame = CGRectMake(0,100,320,230)
        noPlayView.layer.zPosition = 0
        noPlayPopupView.addSubview(noPlayView)
        
        //button 
        
        var startButton = UIButton()
        startButton.frame = CGRectMake(165,155,148,79)
        startButton.setImage(UIImage(named: "btn_start_a"), forState: .Normal)
        startButton.layer.zPosition = 1
        startButton.addTarget(self, action: #selector(newGame), forControlEvents: .TouchUpInside)
        noPlayPopupView.addSubview(startButton)
        //button bright
        var startButtonBright = UIImageView()
        startButtonBright.frame = CGRectMake(165,155,148,79)
        startButtonBright.image = UIImage(named: "btn_start_b")
        startButtonBright.layer.zPosition = 2
        
        noPlayPopupView.addSubview(startButtonBright)
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
            startButtonBright.alpha = 0.2
            }, completion: { finished in
        })
       
        self.view.addSubview(noPlayPopupView)
        
    }
    func newGame(sender: UIButton!){
        print("korn")
        //self.performSegueWithIdentifier(SEGUE_STARTED_GAME, sender: nil)
    }
    func ballFromOpponent(){
        
        var comingBall = UIImageView()
        let image = UIImage(named: "volleyball_001.png")
        comingBall = UIImageView(image: image)
        comingBall.frame = CGRectMake(self.screenSize.width/2-30,200,20,20)
        comingBall.layer.zPosition = 0
        self.view.addSubview(comingBall)
        comingBall.animationImages = [
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
        comingBall.animationDuration = 0.5
        //self.spinBall.animationRepeatCount = 1
        comingBall.startAnimating()
        
        UIView.animateWithDuration(1, animations: {
                var originFrame = comingBall.frame
                originFrame = CGRectMake(self.screenSize.width/2-105, 60, 200, 200)
                comingBall.frame = originFrame
            
            }, completion: { finished in
                UIView.animateWithDuration(2, animations: {
                    var originFrame = comingBall.frame
                    originFrame = CGRectMake(self.screenSize.width/2-200, 120, 400, 400)
                    
                    comingBall.frame = originFrame
                    }, completion: { finished in
                        //print(currentMaxVelocity)
                        //self.lightBling.image = UIImage(named: "img_light.png")
                        self.lightBling.animationImages = [
                            UIImage(named:"img_light.png")!,
                            UIImage(named:"11.png")!
                        ]
                            self.lightBling.animationDuration = 0.3
                            self.lightBling.animationRepeatCount = 0
                            self.lightBling.startAnimating()
                            //self.lightBling.layer.zPosition = 10
                        startPitch(comingBall,lightBling: self.lightBling, game: self)
                        //NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(GameController.afterHitBall), userInfo: nil, repeats: false)
                        
                    })
        })
    }
    func afterHitBall() {
        //var random = arc4random_uniform(80) + 10
        motionManager.stopAccelerometerUpdates()
        self.score.layer.zPosition = 4
        self.kmHr.layer.zPosition = 3
        self.score.format = "%d"
        self.score.countFrom(0, to: CGFloat(currentMaxVelocity), withDuration: 1)
        self.kmHr.image = UIImage(named: "imv_bg_num.png")
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(showResult), userInfo: nil, repeats: true)
          }
    func showResult() {
        self.performSegueWithIdentifier(SEGUE_SHOW_RESULT, sender: nil)
    }
    
}
