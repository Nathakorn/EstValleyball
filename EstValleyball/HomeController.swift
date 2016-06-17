//
//  HomeController.swift
//  EstValleyball
//
//  Created by KORN on 6/9/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit
import Alamofire
class HomeController: UIViewController {
    
    @IBOutlet weak var frontText: UIImageView!
    @IBOutlet weak var homeBackground: UIImageView!
    @IBOutlet weak var brightLogin: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    var ballView = UIImageView()
    var normalButton = UIImageView()
    var blinkButton = UIImageView()
    var login = UIButton()
    
    func loginFacebook() {
        
        let loginManager = FBSDKLoginManager()
        //loginManager.logOut()
        
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
                // var fbId = FBSDKAccessToken.currentAccessToken().userID
                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                /*
                 // FB Access Token
                 var fbAccessToken = FBSDKAccessToken.currentAccessToken().tokenString
                 var url = "https://graph.facebook.com/me/picture?type=large&return_ssl_resource=1&access_token=\(fbAccessToken)"
                 */
            }
        })
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://www.estcolathai.com/volleyballmobile/api/mobile/getDataInfo.aspx")
            .validate()
            .responseJSON { response in
                let json = JSON(data: response.data!)
                youtubeID = json["youtube"].stringValue
                linkWinnerPage = json["page_winner"].stringValue
                winnerNotiCount = json["page_winner"].intValue

                //print(name)
        }
        
        let screenSize = UIScreen.mainScreen().bounds.size
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        homeBackground.layer.zPosition = 1
        frontText.layer.zPosition = 3
        
        if (screenSize.height == 480.0 || screenSize.height == 1024.0){
            print("iphone4s/ipad")
            ballView.frame = CGRectMake(100.0/320.0*screenSize.width, -71.0/480.0*screenSize.height, 403.0/320.0*screenSize.width, 399.0/480.0*screenSize.height)
        }else{
            print("iphone5,6,6plus")
            ballView.frame = CGRectMake(100.0/320.0*screenSize.width, -71.0/568.0*screenSize.height, 403.0/320.0*screenSize.width, 399.0/568.0*screenSize.height)
        }
        ballView.layer.zPosition = 2
        self.view.addSubview(ballView)
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
        self.ballView.animationDuration = 1.5
        self.ballView.startAnimating()
        
        /*
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNamesForFamilyName(familyName )
            print("Font Names = [\(names)]")
        }*/
        
        var buttonRect = CGRect()
        
        print(screenSize.height)
        if (screenSize.height == 480.0 || screenSize.height == 1024.0){
            print("iphone4s/ipad")
            buttonRect = CGRectMake(30.0/320.0*screenSize.width, 180.0/480.0*screenSize.height, 163.0/320.0*screenSize.width, 86.0/480.0*screenSize.height)
            ballView.frame = CGRectMake(100.0/320.0*screenSize.width, -71.0/480.0*screenSize.height, 300.0/320.0*screenSize.width, 300.0/480.0*screenSize.height)
        }else{
            print("iphone5,6,6plus")
            buttonRect = CGRectMake(30.0/320.0*screenSize.width, 157.0/568.0*screenSize.height, 163.0/320.0*screenSize.width, 86.0/568.0*screenSize.height)
        }
        self.normalButton.frame = buttonRect
        self.blinkButton.frame = buttonRect
        self.login.frame = buttonRect
        
        self.normalButton.image = UIImage(named: "btn_login_a")
        self.blinkButton.image = UIImage(named: "btn_login_b")
        
        self.login.addTarget(self, action: #selector(HomeController.loginFacebook), forControlEvents: UIControlEvents.TouchUpInside)
        
        normalButton.layer.zPosition = 4
        blinkButton.layer.zPosition = 5
        login.layer.zPosition = 6
//        self.view.addSubview(self.normalButton)
//        self.view.addSubview(self.blinkButton)
//        self.view.addSubview(self.login)
//        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        } else {
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
                self.blinkButton.alpha = 0.2
            }, completion: { finished in
        })
        NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: #selector(goStartGame), userInfo: nil, repeats: false)
//
//        if (FBSDKAccessToken.currentAccessToken() != nil) {
//            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
//        } else {
//            
//        }
    }
    func goStartGame(){
        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
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
