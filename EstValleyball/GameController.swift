//
//  GameController.swift
//  EstValleyball
//
//  Created by KORN on 6/10/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit
import AudioToolbox
class GameController: UIViewController {
    
    var comingBall = UIImageView()
    var noPlayPopupView = UIView()
    var score = UICountingLabel()
    var kmHr = UIImageView()
    
    var screenSize = UIScreen.mainScreen().bounds.size
    
    @IBOutlet weak var lightBling: UIImageView!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showedMenu"){
            let destination = segue.destinationViewController as! MenuController
            destination.fromSegue = SEGUE_SHOW_GAME
            //self.performSegueWithIdentifier(SEGUE_SHOW_MENU, sender: nil)
        }
    }
    
    // let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    //@IBOutlet weak var comingBall: UIImageView!
    
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
        
        self.score.textAlignment = NSTextAlignment.Center
        
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
       
        noPlayPopupView.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 568/568 * self.screenSize.height)
        noPlayPopupView.backgroundColor = UIColor.blackColor()
        //noPlayPopupView.alpha = 0.3
        var noPlayView = UIImageView()
        let image = UIImage(named: "bg_noplay.png")
        noPlayView = UIImageView(image: image)
        noPlayView.frame = CGRectMake(0,100/568*self.screenSize.height,320/320*self.screenSize.width,230/568*self.screenSize.height)
        noPlayView.layer.zPosition = 0
        noPlayPopupView.addSubview(noPlayView)
        
        //button 
        
        let startButton = UIButton()
        startButton.frame = CGRectMake(165/320*self.screenSize.width,155/568*self.screenSize.height,148/320*self.screenSize.width,79/568*self.screenSize.height)
        startButton.setImage(UIImage(named: "btn_start_a"), forState: .Normal)
        startButton.layer.zPosition = 1
        startButton.addTarget(self, action: #selector(newGame), forControlEvents: .TouchUpInside)
        noPlayPopupView.addSubview(startButton)
        //button bright
        
        var startButtonBright = UIImageView()
        startButtonBright.frame = CGRectMake(165/320*self.screenSize.width,155/568*self.screenSize.height,148/320*self.screenSize.width,79/568*self.screenSize.height)
        startButtonBright.image = UIImage(named: "btn_start_b")
        startButtonBright.layer.zPosition = 2
        
        noPlayPopupView.addSubview(startButtonBright)
        
        //Go to StartedGame
        let goBackButton = UIButton()
        goBackButton.frame = CGRectMake(240/320*self.screenSize.width,110/568*self.screenSize.height,30/320*self.screenSize.width,30/568*self.screenSize.height)
        goBackButton.setImage(UIImage(named: "btn_close_tvc"), forState: .Normal)
        goBackButton.layer.zPosition = 1
        goBackButton.addTarget(self, action: #selector(goBackStartGame), forControlEvents: .TouchUpInside)
        noPlayPopupView.addSubview(goBackButton)
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
            startButtonBright.alpha = 0.2
            }, completion: { finished in
        })
       
        self.view.addSubview(noPlayPopupView)
        
    }
    func hitBallTwo(){
        UIView.animateWithDuration(0.2, animations: {
            var originFrame2 = self.comingBall.frame
            originFrame2 = CGRectMake(self.comingBall.frame.origin.x, 300, 0, 0)
            self.comingBall.frame = originFrame2
           
            }, completion: { finished in
        })
    }
    func goBackStartGame(sender: UIButton){
        self.performSegueWithIdentifier(SEGUE_GOBACK_STARTED_GAME, sender: nil)
    }
    func newGame(segue: UIStoryboardSegue, sender: UIButton!){
        
        print("korn")
        
        self.noPlayPopupView.removeFromSuperview()
        
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
        
        
        /*
        noPlayPopupView.backgroundColor = nil
        for v in noPlayPopupView.subviews{
            v.removeFromSuperview()
        }
        */
        //var goGame = StartGameController()
        
        //let destination = segue.destinationViewController as! MenuController
        //goGame.segue
        //goGame.presentViewController(goGame, animated: true, completion: nil)
        //goGame.performSegueWithIdentifier(SEGUE_STARTED_GAME, sender: nil)
    }
    func ballFromOpponent(){
        
        self.comingBall.removeFromSuperview()
        self.score.text = ""
        self.score.removeFromSuperview()
        self.kmHr.image = nil
        self.kmHr.removeFromSuperview()
        self.comingBall.stopAnimating()
        self.lightBling.stopAnimating()
        
        let image = UIImage(named: "volleyball_001.png")
        self.comingBall = UIImageView(image: image)
        self.comingBall.frame = CGRectMake((self.screenSize.width - (20/320*self.screenSize.width))/2,200/568*self.screenSize.height,20/320*self.screenSize.width,20/320*self.screenSize.width)
        self.comingBall.layer.zPosition = 0
        self.view.addSubview(self.comingBall)
        self.comingBall.animationImages = [
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
        self.comingBall.animationDuration = 0.5
        
        //self.spinBall.animationRepeatCount = 1
        
        self.comingBall.startAnimating()
        
        UIView.animateWithDuration(1, animations: {
                var originFrame = self.comingBall.frame
                originFrame = CGRectMake((self.screenSize.width - (200/320*self.screenSize.width))/2, 60/568*self.screenSize.height, 200/320*self.screenSize.width, 200/320*self.screenSize.width)
                self.comingBall.frame = originFrame
            
            }, completion: { finished in
                UIView.animateWithDuration(2, animations: {
                    var originFrame = self.comingBall.frame
                    originFrame = CGRectMake((self.screenSize.width - (400/320*self.screenSize.width))/2, 120/568*self.screenSize.height, 400/320*self.screenSize.width, 400/320*self.screenSize.width)
                    
                    self.comingBall.frame = originFrame
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
                       
                        startPitch(self.comingBall,lightBling: self.lightBling, game: self)
                        //NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(GameController.afterHitBall), userInfo: nil, repeats: false)
                        
                    })
        })
    }
    
    func afterHitBall() {
        //var random = arc4random_uniform(80) + 10
        motionManager.stopAccelerometerUpdates()
        
        self.score.frame = CGRectMake(53/320*self.screenSize.width, 147/568*self.screenSize.height, 215/320*self.screenSize.width, 273/568*self.screenSize.height)
        self.score.font = UIFont(name: "PSLEmpireProBoldItalic", size: 154.0/568*self.screenSize.height)
        self.score.textColor = UIColor.whiteColor()
        
        self.view.addSubview(self.score)
        
        self.score.layer.zPosition = 4
        
        self.kmHr.layer.zPosition = 3
        self.kmHr.frame = CGRectMake(0, 105/568*self.screenSize.height, 320/320*self.screenSize.width, 357/568*self.screenSize.height)
        
        self.score.format = "%d"
        self.score.countFrom(0, to: CGFloat(currentMaxVelocity), withDuration: 1)
        self.kmHr.image = UIImage(named: "imv_bg_num.png")
        
        self.view.addSubview(self.kmHr)
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(showResult), userInfo: nil, repeats: true)
          }
    func showResult() {
        self.performSegueWithIdentifier(SEGUE_SHOW_RESULT, sender: nil)
    }
    
}
