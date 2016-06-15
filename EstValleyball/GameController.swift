//
//  GameController.swift
//  EstValleyball
//
//  Created by KORN on 6/10/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit
import AudioToolbox
class GameController: UIViewController, FBSDKSharingDelegate {
    var dimBackground = UIImageView()
    var result = UIImageView()
    var comingBall = UIImageView()
    var noPlayPopupView = UIView()
    var resultPopupView = UIView()
    var score = UICountingLabel()
    var facebookNameLabel = UILabel()
    var kmHr = UIImageView()
    var i = 0
    var scoreR = UILabel()
    var profileImageView = UIImageView()
    var capView = UIView()
    var resultView = UIView()
    var screenSize = UIScreen.mainScreen().bounds.size
    var isResult = false
    var facebookCap = UIImageView()
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
        var dimBackground = UIImageView()
        dimBackground.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 568/568 * self.screenSize.height)
        dimBackground.backgroundColor = UIColor.blackColor()
        dimBackground.alpha = 0.6
        noPlayPopupView.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 568/568 * self.screenSize.height)
        dimBackground.layer.zPosition = 1
        noPlayPopupView.addSubview(dimBackground)
        //noPlayPopupView.backgroundColor = UIColor.blackColor()
        //noPlayPopupView.alpha = 0.3
        var noPlayView = UIImageView()
        let image = UIImage(named: "bg_noplay.png")
        noPlayView = UIImageView(image: image)
        noPlayView.frame = CGRectMake(0,100/568*self.screenSize.height,320/320*self.screenSize.width,230/568*self.screenSize.height)
        noPlayView.layer.zPosition = 3
        noPlayPopupView.addSubview(noPlayView)
        
        //button 
        
        let startButton = UIButton()
        startButton.frame = CGRectMake(165/320*self.screenSize.width,155/568*self.screenSize.height,148/320*self.screenSize.width,79/568*self.screenSize.height)
        startButton.setImage(UIImage(named: "btn_start_a"), forState: .Normal)
        startButton.layer.zPosition = 4
        startButton.addTarget(self, action: #selector(newGame), forControlEvents: .TouchUpInside)
        noPlayPopupView.addSubview(startButton)
        //button bright
        
        var startButtonBright = UIImageView()
        startButtonBright.frame = CGRectMake(165/320*self.screenSize.width,155/568*self.screenSize.height,148/320*self.screenSize.width,79/568*self.screenSize.height)
        startButtonBright.image = UIImage(named: "btn_start_b")
        startButtonBright.layer.zPosition = 5
        
        noPlayPopupView.addSubview(startButtonBright)
        
        //Go to StartedGame
        let goBackButton = UIButton()
        goBackButton.frame = CGRectMake(270/320*self.screenSize.width,110/568*self.screenSize.height,30/320*self.screenSize.width,20/568*self.screenSize.height)
        goBackButton.setImage(UIImage(named: "btn_close_tvc"), forState: .Normal)
        goBackButton.layer.zPosition = 4
        goBackButton.addTarget(self, action: #selector(goBackStartGame), forControlEvents: .TouchUpInside)
        noPlayPopupView.addSubview(goBackButton)
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
            startButtonBright.alpha = 0.2
            }, completion: { finished in
        })
       
        self.view.addSubview(noPlayPopupView)
        
    }
    func hitBallTwo(){
        UIView.animateWithDuration(0.4, animations: {
            var originFrame2 = self.comingBall.frame
            originFrame2 = CGRectMake(self.comingBall.frame.origin.x, 280, 0, 0)
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
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(GameController.showResult), userInfo: nil, repeats: false)
        }
    func showResult() {
        self.kmHr.layer.zPosition = 1
        //self.score.alpha = 0.2
        //self.performSegueWithIdentifier(SEGUE_SHOW_RESULT, sender: nil)
        
        dimBackground.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 568/568 * self.screenSize.height)
        dimBackground.backgroundColor = UIColor.blackColor()
        dimBackground.alpha = 0.6
        //resultPopupView.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 524/568 * self.screenSize.height)
        dimBackground.layer.zPosition = 2
        //resultPopupView.addSubview(dimBackground)
        
        //attribute result
        var data : NSData!
        
        var screenSize = UIScreen.mainScreen().bounds.size
        var widthMultiplier = 320 * UIScreen.mainScreen().bounds.size.width
        var heightMultiplier = 568 * UIScreen.mainScreen().bounds.size.height
        
        
        //inside popup view (did appear)
        //currentMaxVelocity = 28
        
        resultView.frame = CGRectMake(0,0,320/320*self.screenSize.width, 524/568*self.screenSize.height)
        
        //print("resultView.frame: \(resultView.frame)")
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        
        
        scoreR.text = String(currentMaxVelocity)
        scoreR.textColor = UIColor.whiteColor()
        scoreR.layer.zPosition = 200
        scoreR.font = UIFont(name: "PSLEmpireProBoldItalic", size: 45.0/568*self.screenSize.height)
        
        
        //rotate image
        let degrees:CGFloat = -8
        profileImageView.transform = CGAffineTransformMakeRotation(degrees * CGFloat(M_PI/180) )
        scoreR.transform = CGAffineTransformMakeRotation(degrees * CGFloat(M_PI/180) )
        
        //resultView.backgroundColor = UIColor.blackColor()
        //noPlayPopupView.alpha = 0.3
        resultView.layer.zPosition = 5
        //var result = UIImageView()
        if currentMaxVelocity > 55{
            let image = UIImage(named: "bg_result1v2.png")
            result = UIImageView(image: image)
            scoreR.frame = CGRectMake(232/320*self.screenSize.width,
                                     260/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 133.0/320*self.screenSize.width
            y = 287.0/568*self.screenSize.height
            
        }
        else if currentMaxVelocity <= 55 && currentMaxVelocity > 45{
            let image = UIImage(named: "bg_result2v2.png")
            result = UIImageView(image: image)
            scoreR.frame = CGRectMake(240/320*self.screenSize.width,
                                     260/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 155.0/320*self.screenSize.width
            y = 290.0/568*self.screenSize.height
        }
        else if currentMaxVelocity <= 45 && currentMaxVelocity > 40{
            let image = UIImage(named: "bg_result3v2.png")
            result = UIImageView(image: image)
            scoreR.frame = CGRectMake(160/320*self.screenSize.width,
                                     214/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 81.0/320*self.screenSize.width
            y = 244.0/568*self.screenSize.height
            
        }
        else if currentMaxVelocity <= 40 && currentMaxVelocity > 30{
            let image = UIImage(named: "bg_result4v2.png")
            result = UIImageView(image: image)
            scoreR.frame = CGRectMake(132/320*self.screenSize.width,
                                     260/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 52.0/320*self.screenSize.width
            y = 290.0/568*self.screenSize.height
        }
        else if currentMaxVelocity <= 30{
            let image = UIImage(named: "bg_result5v2.png")
            result = UIImageView(image: image)
            scoreR.frame = CGRectMake(123/320*self.screenSize.width,
                                     235/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 47.0/320*self.screenSize.width
            y = 265.0/568*self.screenSize.height
        }
        resultView.addSubview(result)
        
        result.frame = CGRectMake(0,44/568*self.screenSize.height,320/320*self.screenSize.width, 524/568*self.screenSize.height)
        result.layer.zPosition = 2
        resultView.addSubview(scoreR)
        /*
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
        req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
            if(error == nil)
            {
                print(result.dictionaryForKey())
            }
            else
            {
                print("error \(error)")
            }
        })*/
        //current
        //print(FBSDKProfile.currentProfile().firstName)
        //print("korn")
        //facebook name
        /*
        var facebookName = FBSDKProfile.currentProfile().name
        facebookNameLabel.text = facebookName
        facebookNameLabel.frame = CGRectMake(132/320*self.screenSize.width,
                                             320/568*self.screenSize.height,
                                             10/320*self.screenSize.width,
                                             10/568*self.screenSize.height)
        facebookNameLabel.layer.zPosition = 3000
        resultView.addSubview(facebookNameLabel)*/
        
        var goBackAndBackButton = UIButton()
        goBackAndBackButton.frame = CGRectMake(280/320*self.screenSize.width,110/568*self.screenSize.height,30/320*self.screenSize.width,30/568*self.screenSize.height)
        goBackAndBackButton.setImage(UIImage(named: "btn_close_tvc"), forState: .Normal)
        goBackAndBackButton.layer.zPosition = 1
        goBackAndBackButton.addTarget(self, action: #selector(goBackStartGame), forControlEvents: .TouchUpInside)
        goBackAndBackButton.layer.zPosition = 6
        resultView.addSubview(goBackAndBackButton)
        
        var startNewGameButton = UIButton()
        startNewGameButton.frame = CGRectMake(30/320*self.screenSize.width,400/568*self.screenSize.height,148/320*self.screenSize.width,79/568*self.screenSize.height)
        startNewGameButton.setImage(UIImage(named: "btn_start_a"), forState: .Normal)
        startNewGameButton.layer.zPosition = 1
        startNewGameButton.addTarget(self, action: #selector(goStartNewGame), forControlEvents: .TouchUpInside)
        resultView.addSubview(startNewGameButton)
        
        var shareButton = UIButton()
        shareButton.frame = CGRectMake(180/320*self.screenSize.width,375/568*self.screenSize.height,148/320*self.screenSize.width,79/568*self.screenSize.height)
        shareButton.setImage(UIImage(named: "btn_share"), forState: .Normal)
        shareButton.layer.zPosition = 1
        shareButton.addTarget(self, action: #selector(fbShareResult), forControlEvents: .TouchUpInside)
        resultView.addSubview(shareButton)
        
        self.view.addSubview(resultView)
        self.view.addSubview(dimBackground)
        self.view.sendSubviewToBack(resultView)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.profileImageView.frame = CGRectMake(x, y, 80.0, 55.0)
            self.profileImageView.layer.zPosition = 100
            
            var fbId = FBSDKAccessToken.currentAccessToken().userID
            let url = NSURL(string:"http://graph.facebook.com/" + fbId + "/picture?type=square")
            data = NSData(contentsOfURL: url!)
            if let image = UIImage(data: data) {
                self.profileImageView.image = image
                self.facebookCap.image = image
            }
            
            self.profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
            self.profileImageView.layer.borderWidth = 1.0
            
            self.view.addSubview(self.profileImageView)
            self.view.bringSubviewToFront(self.profileImageView)
        })
        
        capView.frame = CGRectMake(0.0, 0.0, 300.0/320*self.screenSize.width, 157.5/568*self.screenSize.height)
        var sharePic = UIImageView()
        sharePic.frame = CGRectMake(0.0, 0.0, 300.0/320*self.screenSize.width, 157.5/568*self.screenSize.height)
        let degreeForShare:CGFloat = -7
        var scoreForShare = UILabel()
        scoreForShare.text = String(currentMaxVelocity)
        scoreForShare.textColor = UIColor.whiteColor()
        //scoreForShare.layer.zPosition = 200
        scoreForShare.font = UIFont(name: "PSLEmpireProBoldItalic", size: 28.0/568*self.screenSize.height)
        //scoreForShare.text = "99"
        facebookCap.transform = CGAffineTransformMakeRotation(degreeForShare * CGFloat(M_PI/180) )
        scoreForShare.transform = CGAffineTransformMakeRotation(degreeForShare * CGFloat(M_PI/180) )
       
        if currentMaxVelocity > 55{
            sharePic.image = UIImage(named: "share1.png")
            facebookCap.frame  = CGRectMake(150/320*self.screenSize.width, 85/568*self.screenSize.height,40.0/320*self.screenSize.width, 40/568*self.screenSize.height)
            facebookCap.layer.zPosition = 4000
            scoreForShare.frame = CGRectMake(205/320*self.screenSize.width, 75/568*self.screenSize.height,30.0/320*self.screenSize.width, 30/568*self.screenSize.height)
            scoreForShare.layer.zPosition = 4001
        }
        else if currentMaxVelocity <= 55 && currentMaxVelocity > 45{
            sharePic.image = UIImage(named: "share2.png")
            facebookCap.frame  = CGRectMake(150/320*self.screenSize.width, 85/568*self.screenSize.height,40.0/320*self.screenSize.width, 40/568*self.screenSize.height)
            facebookCap.layer.zPosition = 4000
            scoreForShare.frame = CGRectMake(205/320*self.screenSize.width, 75/568*self.screenSize.height,30.0/320*self.screenSize.width, 30/568*self.screenSize.height)
            scoreForShare.layer.zPosition = 4001
        }
        else if currentMaxVelocity <= 45 && currentMaxVelocity > 40{
            sharePic.image = UIImage(named: "share3.png")
            facebookCap.frame  = CGRectMake(150/320*self.screenSize.width, 85/568*self.screenSize.height,40.0/320*self.screenSize.width, 40/568*self.screenSize.height)
            facebookCap.layer.zPosition = 4000
            scoreForShare.frame = CGRectMake(205/320*self.screenSize.width, 75/568*self.screenSize.height,30.0/320*self.screenSize.width, 30/568*self.screenSize.height)
            scoreForShare.layer.zPosition = 4001
        }
        else if currentMaxVelocity <= 40 && currentMaxVelocity > 30{
            sharePic.image = UIImage(named: "share4.png")
            facebookCap.frame  = CGRectMake(70/320*self.screenSize.width, 95/568*self.screenSize.height,40.0/320*self.screenSize.width, 40/568*self.screenSize.height)
            facebookCap.layer.zPosition = 4000
            scoreForShare.frame = CGRectMake(125/320*self.screenSize.width, 80/568*self.screenSize.height,30.0/320*self.screenSize.width, 30/568*self.screenSize.height)
            scoreForShare.layer.zPosition = 4001
        }
        else if currentMaxVelocity <= 30{
            sharePic.image = UIImage(named: "share5.png")
            facebookCap.frame  = CGRectMake(70/320*self.screenSize.width, 95/568*self.screenSize.height,40.0/320*self.screenSize.width, 40/568*self.screenSize.height)
            facebookCap.layer.zPosition = 4000
            scoreForShare.frame = CGRectMake(125/320*self.screenSize.width, 80/568*self.screenSize.height,30.0/320*self.screenSize.width, 30/568*self.screenSize.height)
            scoreForShare.layer.zPosition = 4001
        }
        capView.addSubview(sharePic)
        capView.addSubview(scoreForShare)
        //capView.addSubview(dimBackground)
        capView.addSubview(facebookCap)
        
        
        //score.format = "%d"
        scoreR.text = String(currentMaxVelocity)
        //print(FBSDKAccessToken.currentAccessToken().userID)
        
        // facebookImg.image = UIImage(data:data!)
    
        self.view.addSubview(resultPopupView)
    }
    func fbShareResult(sender: UIButton) {
        var resultImage = UIImageView(frame: CGRectMake(0.0, 0.0, 200.0/320*self.screenSize.width, 200.0/568*self.screenSize.height))
        resultImage.image = UIImage(named: "14.png")
        
        //        var button = UIImageView(frame: CGRectMake(50.0/320*self.screenSize.width, 50.0/568*self.screenSize.height, 50.0/320*self.screenSize.width, 50.0/568*self.screenSize.height))
        //        button.image = UIImage(named: "V_Spin_00000.png")
        //        button.contentMode = UIViewContentMode.ScaleAspectFit
        
        // resultImage.addSubview(button)
        
        UIGraphicsBeginImageContextWithOptions(capView.frame.size, true, UIScreen.mainScreen().scale)
        var ctx: CGContextRef = UIGraphicsGetCurrentContext()!
        capView.layer.renderInContext(ctx)
        var shareImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        var photo = FBSDKSharePhoto()
        photo.image = shareImage
        photo.userGenerated = true
        var photoContent = FBSDKSharePhotoContent()
        
        photoContent.photos = [photo]
        FBSDKShareDialog.showFromViewController(self, withContent: photoContent, delegate: self)
        
        //        var dialog = FBSDKShareDialog()
        //        dialog.mode = FBSDKShareDialogMode.FeedBrowser
        //
        //        dialog.shareContent = photoContent
        //        dialog.delegate = self
        //        dialog.fromViewController = self
        //
        //        dialog.show()
        
        print("isCurrentAccessToken: \(FBSDKAccessToken.currentAccessToken() != nil)")
        
        /*
         if let image = UIImage(named: "btn_menu6_active.png") {
         photoContent.photos = [image]
         FBSDKShareDialog.showFromViewController(self, withContent: photoContent, delegate: nil)
         } else {
         print("no photo found")
         }
         */
        
    }
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("didCancel")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("didFailWithError: \(error.localizedDescription)")
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        print("didCompleteWithResults")
    }
    func goStartNewGame(sender: UIButton){
        currentMaxVelocity = 0
        motionManager.stopAccelerometerUpdates()
        self.noPlayPopupView.removeFromSuperview()
        self.resultView.removeFromSuperview()
        self.profileImageView.removeFromSuperview()
        self.kmHr.removeFromSuperview()
        self.dimBackground.removeFromSuperview()
        result.removeFromSuperview()
        currentMaxAccelX = 0.0
        currentMaxAccelY = 0.0
        currentMaxAccelZ = 0.0
        currentMaxVelocity = 0
        scoreR.removeFromSuperview()
       // isResult == true
        
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
        
    }


    
}
