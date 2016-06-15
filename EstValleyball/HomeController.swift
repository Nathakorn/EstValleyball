//
//  HomeController.swift
//  EstValleyball
//
//  Created by KORN on 6/9/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var brightLogin: UIImageView!
    @IBOutlet weak var ballView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
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
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
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
        
        
        var screenSize = UIScreen.mainScreen().bounds.size
        var buttonRect = CGRectMake(30.0/320.0*screenSize.width, 157.0/568.0*screenSize.height, 163.0/320.0*screenSize.width, 86.0/568.0*screenSize.height)
        
        self.normalButton.frame = buttonRect
        self.blinkButton.frame = buttonRect
        self.login.frame = buttonRect
        
        self.normalButton.image = UIImage(named: "Login with Facebook")
        self.blinkButton.image = UIImage(named: "btn_login_b")
        
        self.login.addTarget(self, action: #selector(HomeController.loginFacebook), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.normalButton)
        self.view.addSubview(self.blinkButton)
        self.view.addSubview(self.login)
        
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
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        } else {
            
        }
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
