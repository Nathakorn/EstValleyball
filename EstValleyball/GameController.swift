//
//  GameController.swift
//  EstValleyball
//
//  Created by KORN on 6/10/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit
import AudioToolbox
import Alamofire
import AVFoundation

class GameController: UIViewController, FBSDKSharingDelegate {
    
    var shareImg: String = ""
    var gid: String = ""
    
    let keychain = KeychainSwift()
    
    var dimBackgroundForNoPlay = UIImageView()
    var dimBackground = UIImageView()
    var result = UIImageView()
    var comingBall = UIImageView()
    var noPlayPopupView = UIView()
    var resultPopupView = UIView()
    var score = UICountingLabel()
    var shareButton = UIButton()
    var facebookNameLabel = UILabel()
    var kmHr = UIImageView()
    var scoreR = UILabel()
    var profileImageView = UIImageView()
    var capView = UIView()
    var resultView = UIView()
    var screenSize = UIScreen.mainScreen().bounds.size
    var facebookCap = UIImageView()
    var audioPlayer: AVAudioPlayer!
    var thankyouText = UIImageView()
    
    var grayView = UIView()
    var loadingView = UIView()
    
    var i = 0
    var isResult = false
    
    var timers = [NSTimer]()
    
    @IBOutlet weak var lightBling: UIImageView!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showedMenu"){
            self.stopSound()
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
        
        self.initLoadingView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        //number countdown
        
        self.score.textAlignment = NSTextAlignment.Center
        
        if (!self.isResult) {
            self.goStartNewGame()
        }
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Page, action: .Opened, label: "Countdown Before Start Game Page")
        
    }
    
    func showNoplay(){
       //let dimBackgroundForNoPlay = UIImageView()
        dimBackgroundForNoPlay.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 568/568 * self.screenSize.height)
        dimBackgroundForNoPlay.backgroundColor = UIColor.blackColor()
        dimBackgroundForNoPlay.alpha = 0.6
        noPlayPopupView.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 568/568 * self.screenSize.height)
        dimBackgroundForNoPlay.layer.zPosition = 1
        noPlayPopupView.addSubview(dimBackgroundForNoPlay)
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
        startButton.addTarget(self, action: #selector(goStartNewGame), forControlEvents: .TouchUpInside)
        noPlayPopupView.addSubview(startButton)
        //button bright
        
        let startButtonBright = UIImageView()
        startButtonBright.frame = CGRectMake(165/320*self.screenSize.width,155/568*self.screenSize.height,148/320*self.screenSize.width,79/568*self.screenSize.height)
        startButtonBright.image = UIImage(named: "btn_start_b")
        startButtonBright.layer.zPosition = 5
        
        if (screenSize.height == 480.0 || screenSize.height == 1024.0){
           
        }else{
           noPlayPopupView.addSubview(startButtonBright)
        }
        //noPlayPopupView.addSubview(startButtonBright)
        
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
        motionManager.stopAccelerometerUpdates()
        UIView.animateWithDuration(0.4, animations: {
            var originFrame2 = self.comingBall.frame
            originFrame2 = CGRectMake(self.comingBall.frame.origin.x, 240/568*self.screenSize.height, 0, 0)
            self.comingBall.frame = originFrame2
            self.playAfterHitSound()
            }, completion: { finished in
        })
    }
    
    func goBackStartGame(sender: UIButton){
        self.performSegueWithIdentifier(SEGUE_GOBACK_STARTED_GAME, sender: nil)
    }
    
    func newGame(segue: UIStoryboardSegue, sender: UIButton!){
        
        NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: #selector(playCountdownSound), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(playCountdownSound), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(playCountdownSound), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(playStartSound), userInfo: nil, repeats: false)

        self.noPlayPopupView.removeFromSuperview()
        dimBackgroundForNoPlay.removeFromSuperview()
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
                            UIImage(named:"black_point.png")!
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
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Page, action: .Opened, label: "Game Page")
        
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
        
        self.isResult = true
        
        kmHr.alpha = 0.3
        self.kmHr.layer.zPosition = 1
        
        dimBackground.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 568/568 * self.screenSize.height)
        dimBackground.backgroundColor = UIColor.blackColor()
        dimBackground.alpha = 0.6
        //resultPopupView.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 524/568 * self.screenSize.height)
        dimBackground.layer.zPosition = 2
        //resultPopupView.addSubview(dimBackground)
        
        //attribute result
        var data : NSData!
        
        _ = UIScreen.mainScreen().bounds.size
        _ = 320 * UIScreen.mainScreen().bounds.size.width
        _ = 568 * UIScreen.mainScreen().bounds.size.height
        
        resultView.frame = CGRectMake(0,0,320/320*self.screenSize.width, 524/568*self.screenSize.height)
        
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
        if currentMaxVelocity >= 90 && currentMaxVelocity < 100{
            let image = UIImage(named: "bg_result1v2.png")
            result = UIImageView(image: image)
            scoreR.frame = CGRectMake(195/320*self.screenSize.width,
                                     280/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 133.0/320*self.screenSize.width
            y = 287.0/568*self.screenSize.height
            
        }
        else if currentMaxVelocity >= 80 && currentMaxVelocity < 90{
            let image = UIImage(named: "bg_result2v2.png")
            result = UIImageView(image: image)
            scoreR.frame = CGRectMake(207/320*self.screenSize.width,
                                     263/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 155.0/320*self.screenSize.width
            y = 290.0/568*self.screenSize.height
        }
        else if currentMaxVelocity >= 70 && currentMaxVelocity < 80{
            let image = UIImage(named: "bg_result3v2.png")
            result = UIImageView(image: image)
            scoreR.frame = CGRectMake(85/320*self.screenSize.width,
                                     255/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 76.0/320*self.screenSize.width
            y = 240.0/568*self.screenSize.height
            
        }
        else if currentMaxVelocity >= 60 && currentMaxVelocity < 70{
            let image = UIImage(named: "bg_result4v2.png")
            result = UIImageView(image: image)
            scoreR.frame = CGRectMake(100/320*self.screenSize.width,
                                     284/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 50.0/320*self.screenSize.width
            y = 289.0/568*self.screenSize.height
        }
        else if currentMaxVelocity < 60{
            let image = UIImage(named: "bg_result5v2.png")
            result = UIImageView(image: image)
            scoreR.frame = CGRectMake(93/320*self.screenSize.width,
                                     252/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 47.0/320*self.screenSize.width
            y = 265.0/568*self.screenSize.height
        }
        resultView.addSubview(result)
        
        result.frame = CGRectMake(0,44/568*self.screenSize.height,320/320*self.screenSize.width, 524/568*self.screenSize.height)
        result.layer.zPosition = 2
        resultView.addSubview(scoreR)
        
        let goBackAndBackButton = UIButton()
        goBackAndBackButton.frame = CGRectMake(280/320*self.screenSize.width,110/568*self.screenSize.height,30/320*self.screenSize.width,30/568*self.screenSize.height)
        goBackAndBackButton.setImage(UIImage(named: "btn_close_tvc"), forState: .Normal)
        goBackAndBackButton.layer.zPosition = 1
        goBackAndBackButton.addTarget(self, action: #selector(goBackStartGame), forControlEvents: .TouchUpInside)
        goBackAndBackButton.layer.zPosition = 6
        resultView.addSubview(goBackAndBackButton)
        
        let startNewGameButton = UIButton()
        startNewGameButton.frame = CGRectMake(15/320*self.screenSize.width,400/568*self.screenSize.height,148/320*self.screenSize.width,79/568*self.screenSize.height)
        startNewGameButton.setImage(UIImage(named: "btn_replay"), forState: .Normal)
        startNewGameButton.layer.zPosition = 1
        startNewGameButton.addTarget(self, action: #selector(goStartNewGame), forControlEvents: .TouchUpInside)
        resultView.addSubview(startNewGameButton)
        
        thankyouText.frame = CGRectMake(13/320*self.screenSize.width,438/568*self.screenSize.height,294/320*self.screenSize.width,122/568*self.screenSize.height)
        thankyouText.image = UIImage(named: "txt_result")
        thankyouText.layer.zPosition = 9000
        resultView.addSubview(thankyouText)
        
        self.shareButton.frame = CGRectMake(165/320*self.screenSize.width,375/568*self.screenSize.height,148/320*self.screenSize.width,79/568*self.screenSize.height)
        self.shareButton.setImage(UIImage(named: "btn_share"), forState: .Normal)
        self.shareButton.layer.zPosition = 1
        self.shareButton.addTarget(self, action: #selector(fbShareResult), forControlEvents: .TouchUpInside)
        resultView.addSubview(shareButton)
        
        self.view.addSubview(resultView)
        self.view.addSubview(dimBackground)
        self.view.sendSubviewToBack(resultView)
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Page, action: .Opened, label: "Result Page")
    
        self.view.addSubview(resultPopupView)
        
    }
    
    func fbShareResult(sender: UIButton) {
        
        // todo -> loading screen
        
        self.showLoadingView()
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "Share")
        
        if let _ = FBSDKAccessToken.currentAccessToken() {
            // self.shareFacebookResult()
            let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email,gender,link,first_name,last_name"], HTTPMethod: "GET")
            let connection = FBSDKGraphRequestConnection()
            connection.addRequest(request, completionHandler: { (conn, result, error) -> Void in
                if (error != nil) {
                    print("\(error.localizedDescription)")
                } else {
                    var json = JSON(result)
                    
                    // var params = Dictionary<String, AnyObject>()
                    
                    if let firstname = json["first_name"].string {
                        self.keychain.set(firstname, forKey: "firstname")
                    }
                    
                    if let lastname = json["last_name"].string {
                        self.keychain.set(lastname, forKey: "lastname")
                    }
                    
                    if let email = json["email"].string {
                        self.keychain.set(email, forKey: "email")
                    }
                    
                    if let gender = json["gender"].string {
                        self.keychain.set(gender, forKey: "gender")
                    }
                    
                    if let link = json["link"].string {
                        self.keychain.set(link, forKey: "link")
                    }
                    
                    self.shareFacebookResult()
                }
            })
            
            connection.start()
        } else {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            
            loginManager.loginBehavior = FBSDKLoginBehavior.Browser
            
            loginManager.logInWithReadPermissions(["public_profile", "email", "user_about_me"], fromViewController: self, handler: {
                (result: FBSDKLoginManagerLoginResult!, error: NSError?) -> Void in
                if (error != nil) {
                    // fb login error
                } else if (result.isCancelled) {
                    // fb login cancelled
                } else if (result.declinedPermissions.contains("public_profile") || result.declinedPermissions.contains("email") || result.declinedPermissions.contains("user_about_me")) {
                    // declined "public_profile", "email" or "user_about_me"
                } else {
                    // TODO: api to update facebookid-nontoken
                    var parameters = [
                        "access": "mobileapp",
                        "caller": "json"
                    ]
                    
                    if let uid = self.keychain.get("uid") {
                        parameters["fakefbuid"] = uid
                    }
                    
                    let fbuid = FBSDKAccessToken.currentAccessToken().userID
                    self.keychain.set(fbuid, forKey: "uid")
                    
                    parameters["fbuid"] = fbuid
                    
                    // let dicPost: NSMutableDictionary = NSMutableDictionary()
                    // let request = FBSDKGraphRequest(graphPath: "me", parameters: dicPost as [NSObject : AnyObject], HTTPMethod: "GET")
                    let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email,gender,link,first_name,last_name"], HTTPMethod: "GET")
                    let connection = FBSDKGraphRequestConnection()
                    connection.addRequest(request, completionHandler: { (conn, result, error) -> Void in
                        if (error != nil) {
                            print("\(error.localizedDescription)")
                        } else {
                            var json = JSON(result)
                            
                            // var params = Dictionary<String, AnyObject>()
                            
                            if let firstname = json["first_name"].string {
                                parameters["firstname"] = json["first_name"].string
                                if self.keychain.set(firstname, forKey: "firstname") {
                                    print("add success")
                                } else {
                                    print("add failed")
                                }
                            }
                            
                            if let lastname = json["last_name"].string {
                                parameters["lastname"] = json["last_name"].string
                                self.keychain.set(lastname, forKey: "lastname")
                            }
                            
                            if let email = json["email"].string {
                                parameters["email"] = json["email"].string
                                self.keychain.set(email, forKey: "email")
                            }
                            
                            if let gender = json["gender"].string {
                                parameters["gender"] = json["gender"].string
                                self.keychain.set(gender, forKey: "gender")
                            }
                            
                            if let link = json["link"].string {
                                parameters["profilelink"] = json["link"].string
                                self.keychain.set(link, forKey: "link")
                            }
                            
                            for (key, value) in parameters {
                                print("\(key): \(value)")
                            }
                            
                            Alamofire.request(.POST, "http://www.estcolathai.com/volleyballmobile/api/mobile/getinfoV3NonToken.aspx", parameters: parameters)
                            
                            self.shareFacebookResult()
                        }
                    })
                    
                    connection.start()
                    
                }
            })
        }
        
        print("isCurrentAccessToken: \(FBSDKAccessToken.currentAccessToken() != nil)")
        
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("didCancel")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("didFailWithError: \(error.localizedDescription)")
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        print("didCompleteWithResults")
        
        var parameters = Dictionary<String, AnyObject>()
        parameters["gid"] = gid
        parameters["type"] = "postshare"
        parameters["access"] = "mobileapp"
        parameters["caller"] = "json"
        parameters["code"] = FBSDKAccessToken.currentAccessToken().tokenString
        
        Alamofire.request(.POST, "http://www.estcolathai.com/volleyballmobile/api/mobile/saveShareToWall.aspx", parameters: parameters)
        
        parameters = Dictionary<String, AnyObject>()
        
        parameters["stat"] = "estvolleyball"
        parameters["param1"] = "ios"
        parameters["param2"] = "shareresult"
        
        Alamofire.request(.GET, "http://www.estcolathai.com/volleyballmobile/api/mobile/applicationstatlog.aspx", parameters: parameters)
        
    }
    
    func shareFacebookResult() {
        
        self.captureShareImage(Callback() { (imageUrl, success, errorString, error) in
            if (success) {
                if let urlString: String = imageUrl {
                    
                    var params = (UIApplication.sharedApplication().delegate as! AppDelegate).parameters
                    
                    var shareUrl = "http://www.estcolathai.com/volleyballmobile/app_install.php"
                    if let newShareUrl = params["share_url"] {
                        shareUrl = newShareUrl
                    }
                    
                    let contentImg = NSURL(string: urlString)
                    let contentURL = NSURL(string: shareUrl)
                    
                    var contentTitle = "ดวลลูกตบเอส ชิงบัตรเชียร์วอลเลย์บอลเวิลด์กรังด์ปรีซ์ ตั้งแต่วันนี้ - 28 มิ.ย. 59"
                    if let title = params["share_title"] {
                        contentTitle = title
                    }
                    
                    var contentDescription = "เอส โคล่า ขอท้าคุณมาโชว์พลังตบให้แรงระดับชาติกับแอพสุดซ่า ชิงบัตรเวิลด์กรังด์ปรีซ์รอบสุดท้าย แล้วไปเชียร์สุดซี้ดติดขอบสนาม!!"
                    if let description = params["share_description"] {
                        contentDescription = description
                    }
                    
                    let photoContent: FBSDKShareLinkContent = FBSDKShareLinkContent()
                    
                    photoContent.contentURL = contentURL
                    photoContent.contentTitle = contentTitle
                    photoContent.contentDescription = contentDescription
                    photoContent.imageURL = contentImg
                    
                    let dialog = FBSDKShareDialog()
                    dialog.mode = FBSDKShareDialogMode.FeedBrowser
                    dialog.shareContent = photoContent
                    dialog.delegate = self
                    dialog.fromViewController = self
                    
                    self.hideLoadingView()
                    
                    dialog.show()
                }
            } else {
                // TODO: error
            }
        })
        
    }
    
    func captureShareImage(cb: Callback<String>) {
        
        let fbId = FBSDKAccessToken.currentAccessToken().userID
        let url = NSURL(string:"http://graph.facebook.com/" + fbId + "/picture?type=square")
        // let url = NSURL(string:"http://graph.facebook.com/" + fbId + "/picture?type=square&height=800&width=800")
        let data = NSData(contentsOfURL: url!)
        if let data = data {
            if let image = UIImage(data: data) {
                self.facebookCap.image = image
            }
        }
        
        self.profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileImageView.layer.borderWidth = 1.0
        
        // self.view.addSubview(self.profileImageView)
        // self.view.bringSubviewToFront(self.profileImageView)
        
        self.capView.frame = CGRectMake(0.0, 0.0, 300.0/320*self.screenSize.width, 157.5/568*self.screenSize.height)
        let sharePic = UIImageView()
        sharePic.frame = CGRectMake(0.0, 0.0, 300.0/320*self.screenSize.width, 157.5/568*self.screenSize.height)
        let degreeForShare:CGFloat = -7
        let scoreForShare = UILabel()
        scoreForShare.text = String(currentMaxVelocity)
        scoreForShare.textColor = UIColor.whiteColor()
        //scoreForShare.layer.zPosition = 200
        scoreForShare.font = UIFont(name: "PSLEmpireProBoldItalic", size: 28.0/568*self.screenSize.height)
        
        let facebookCapView = UIView()
        //scoreForShare.text = "99"
        
        scoreForShare.transform = CGAffineTransformMakeRotation(degreeForShare * CGFloat(M_PI/180) )
        
        if currentMaxVelocity >= 90 && currentMaxVelocity < 100{
            sharePic.image = UIImage(named: "share1.png")
            facebookCapView.frame  = CGRectMake(150/320*self.screenSize.width, 85/568*self.screenSize.height,40.0/320*self.screenSize.width, 40.0/320*self.screenSize.width)
            self.facebookCap.layer.zPosition = 4000
            scoreForShare.frame = CGRectMake(207/320*self.screenSize.width, 75/568*self.screenSize.height,30.0/320*self.screenSize.width, 30/568*self.screenSize.height)
            scoreForShare.layer.zPosition = 4001
        }
        else if currentMaxVelocity >= 80 && currentMaxVelocity < 90{
            sharePic.image = UIImage(named: "share2.png")
            facebookCapView.frame  = CGRectMake(150/320*self.screenSize.width, 85/568*self.screenSize.height,40.0/320*self.screenSize.width, 40.0/320*self.screenSize.width)
            self.facebookCap.layer.zPosition = 4000
            scoreForShare.frame = CGRectMake(207/320*self.screenSize.width, 75/568*self.screenSize.height,30.0/320*self.screenSize.width, 30/568*self.screenSize.height)
            scoreForShare.layer.zPosition = 4001
        }
        else if currentMaxVelocity >= 70 && currentMaxVelocity < 80{
            sharePic.image = UIImage(named: "share3.png")
            facebookCapView.frame  = CGRectMake(150/320*self.screenSize.width, 85/568*self.screenSize.height,40.0/320*self.screenSize.width, 40.0/320*self.screenSize.width)
            self.facebookCap.layer.zPosition = 4000
            scoreForShare.frame = CGRectMake(207/320*self.screenSize.width, 75/568*self.screenSize.height,30.0/320*self.screenSize.width, 30/568*self.screenSize.height)
            scoreForShare.layer.zPosition = 4001
        }
        else if currentMaxVelocity >= 60 && currentMaxVelocity < 70{
            sharePic.image = UIImage(named: "share4.png")
            facebookCapView.frame  = CGRectMake(70/320*self.screenSize.width, 95/568*self.screenSize.height,40.0/320*self.screenSize.width, 40.0/320*self.screenSize.width)
            self.facebookCap.layer.zPosition = 4000
            scoreForShare.frame = CGRectMake(125/320*self.screenSize.width, 87/568*self.screenSize.height,30.0/320*self.screenSize.width, 30/568*self.screenSize.height)
            scoreForShare.layer.zPosition = 4001
        }
        else if currentMaxVelocity < 60{
            sharePic.image = UIImage(named: "share5.png")
            facebookCapView.frame  = CGRectMake(70/320*self.screenSize.width, 95/568*self.screenSize.height,40.0/320*self.screenSize.width, 40.0/320*self.screenSize.width)
            self.facebookCap.layer.zPosition = 4000
            scoreForShare.frame = CGRectMake(125/320*self.screenSize.width, 84/568*self.screenSize.height,30.0/320*self.screenSize.width, 30/568*self.screenSize.height)
            scoreForShare.layer.zPosition = 4001
        }
        
        //white background view
        self.facebookCap.frame = CGRectMake(1/320*self.screenSize.width, 1/568*self.screenSize.height,38.0/320*self.screenSize.width, 38.0/320*self.screenSize.width)
        
        facebookCapView.addSubview(self.facebookCap)
        facebookCapView.layer.zPosition = 7000
        facebookCapView.backgroundColor = UIColor.whiteColor()
        facebookCapView.transform = CGAffineTransformMakeRotation(-8 * CGFloat(M_PI/180) )
        self.capView.addSubview(sharePic)
        self.capView.addSubview(scoreForShare)
        self.capView.addSubview(facebookCapView)
        
        // -> got capView
        
        UIGraphicsBeginImageContextWithOptions(self.capView.frame.size, true, UIScreen.mainScreen().scale)
        let ctx: CGContextRef = UIGraphicsGetCurrentContext()!
        self.capView.layer.renderInContext(ctx)
        let shareImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageData:NSData = UIImagePNGRepresentation(shareImage)!
        
        var parameters = Dictionary<String, AnyObject>()
        
        parameters["imggallery"] = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        parameters["param1"] = String(currentMaxVelocity)
        parameters["param2"] = String(currentMaxVelocity)
        parameters["param3"] = "sensor"
        parameters["access"] = "mobile"
        parameters["code"] =  FBSDKAccessToken.currentAccessToken().tokenString
        parameters["caller"] = "json"
        parameters["fbuid"] = FBSDKAccessToken.currentAccessToken().userID
        
        if let firstname = self.keychain.get("firstname") {
            parameters["firstname"] = firstname
        }
        
        if let lastname = self.keychain.get("lastname") {
            parameters["lastname"] = lastname
        }
        
        if let email = self.keychain.get("email") {
            parameters["email"] = email
        }
        
        if let gender = self.keychain.get("gender") {
            parameters["gender"] = gender
        }
        
        if let link = self.keychain.get("link") {
            parameters["profilelink"] = link
        }
        
        for (key, value) in parameters {
            if (key != "imggallery") {
                print("submitGameNonToken with fbuid: \(key), \(value)")
            }
        }
        
        Alamofire.request(.POST, "http://www.estcolathai.com/volleyballmobile/api/mobile/submitGameNonToken.aspx", parameters: parameters).responseJSON
            { response in switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSDictionary
                    let result = response.objectForKey("result")! as! String
                    if(result == "complete") {
                        self.gid = response.objectForKey("gid")! as! String
                        self.shareImg = response.objectForKey("img")! as! String
                        cb.callback(self.shareImg, true, nil, nil)
                    }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    cb.callback(nil, false, nil, error)
            }
        }
        
    }
    
    func goStartNewGame() {
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "Replay")
        
        var parameters = Dictionary<String, AnyObject>()
        
        parameters["param1"] = String(currentMaxVelocity)
        parameters["param2"] = String(currentMaxVelocity)
        parameters["param3"] = "sensor"
        parameters["access"] = "mobile"
        parameters["caller"] = "json"
        
        if let uid = self.keychain.get("uid") {
            parameters["fbuid"] = uid
        }
        
        if let firstname = self.keychain.get("firstname") {
            parameters["firstname"] = firstname
        }
        
        if let lastname = self.keychain.get("lastname") {
            parameters["lastname"] = lastname
        }
        
        if let email = self.keychain.get("email") {
            parameters["email"] = email
        }
        
        if let gender = self.keychain.get("gender") {
            parameters["gender"] = gender
        }
        
        if let link = self.keychain.get("link") {
            parameters["profilelink"] = link
        }
        
        for (key, value) in parameters {
            if (key != "imggallery") {
                print("submitGameNonToken with fbuid: \(key), \(value)")
            }
        }
        
        Alamofire.request(.POST, "http://www.estcolathai.com/volleyballmobile/api/mobile/submitGameNonToken.aspx", parameters: parameters).responseJSON
            { response in switch response.result {
                case .Success(let JSON):
                    print("Request success with json \(JSON)")
                case .Failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.timers.append(NSTimer.scheduledTimerWithTimeInterval(0.0, target: self, selector: #selector(GameController.playCountdownSound), userInfo: nil, repeats: false))
            self.timers.append(NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameController.playCountdownSound), userInfo: nil, repeats: false))
            self.timers.append(NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(GameController.playCountdownSound), userInfo: nil, repeats: false))
            self.timers.append(NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(GameController.playStartSound), userInfo: nil, repeats: false))
        })
        
        /*
        self.timers.append(NSTimer.init(timeInterval: 0.0, target: self, selector: #selector(playCountdownSound), userInfo: nil, repeats: false))
        self.timers.append(NSTimer.init(timeInterval: 1.0, target: self, selector: #selector(playCountdownSound), userInfo: nil, repeats: false))
        self.timers.append(NSTimer.init(timeInterval: 2.0, target: self, selector: #selector(playCountdownSound), userInfo: nil, repeats: false))
         */
        
        kmHr.alpha = 1
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
        self.isResult = false
        
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
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Page, action: .Opened, label: "Countdown Before Start Game Page")
        
    }
    
    func playHitSound(){
        playSound("Sound_1")
    }
    func playAfterHitSound(){
        playSound("Sound_2")
    }
    func playCountdownSound(){
        playSound("Sound_3")
    }
    func playStartSound(){
        playSound("Sound_4")
    }
    
    func playSound(soundName: String)
    {
        let soundURL: NSURL = NSBundle.mainBundle().URLForResource(soundName, withExtension: "mp3")!
        audioPlayer = try! AVAudioPlayer(contentsOfURL: soundURL)
        audioPlayer.play()
    }
    
    func stopSound() {
        for timer in self.timers {
            timer.invalidate()
        }
        self.timers.removeAll(keepCapacity: false)
    }
    
    func initLoadingView() {
        let screen = UIScreen.mainScreen().bounds.size
        
        self.grayView.layer.zPosition = 10000
        self.loadingView.layer.zPosition = 20000
        
        self.grayView.frame = CGRectMake(0.0, 0.0, screen.width, screen.height)
        self.grayView.backgroundColor = UIColor.blackColor()
        self.grayView.alpha = 0.3
        
        self.loadingView.frame = CGRectMake((screen.width - 150.0) / 2.0, (screen.height - 50.0) / 2.0, 150.0, 50.0)
        self.loadingView.backgroundColor = UIColor.clearColor()
        self.loadingView.layer.cornerRadius = 5.0
        self.loadingView.clipsToBounds = true
        
        
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        loadingIndicator.backgroundColor = UIColor.clearColor()
        loadingIndicator.frame = CGRectMake(50.0, 0.0, 50.0, 50.0)
        loadingIndicator.startAnimating()
        
        /*
        let loadingLabel = UILabel(frame: CGRectMake(0.0, 0.0, 150.0, 50.0))
        loadingLabel.textAlignment = NSTextAlignment.Center
        loadingLabel.textColor = UIColor.blackColor()
        loadingLabel.font = UIFont.systemFontOfSize(20.0)
        loadingLabel.text = "Loading ..."
        loadingLabel.backgroundColor = UIColor.clearColor()
         */
        
        self.loadingView.addSubview(loadingIndicator)
    }
    
    func showLoadingView() {
        self.view.addSubview(self.grayView)
        self.view.addSubview(self.loadingView)
    }
    
    func hideLoadingView() {
        self.grayView.removeFromSuperview()
        self.loadingView.removeFromSuperview()
    }
}
