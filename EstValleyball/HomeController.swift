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
    
    @IBOutlet weak var homeBackground: UIImageView!
    @IBOutlet weak var frontText: UIImageView!
    
    var ballView = UIImageView()
    var normalButton = UIImageView()
    var blinkButton = UIImageView()
    var login = UIButton()
    
    var tapGesture: UITapGestureRecognizer?
    var tapGestureView = UIView()
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var loginManager = FBSDKLoginManager()
//        loginManager.logOut()
//        
//        KeychainSwift().clear()
 
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Page, action: .Opened, label: "Home Page")
        
        Alamofire.request(.GET, "http://www.estcolathai.com/volleyballmobile/api/mobile/getDataInfo.aspx")
            .validate()
            .responseJSON { response in
                if let data = response.data {
                    let json = JSON(data: data)
                    
                    // var parameters = (UIApplication.sharedApplication().delegate as! AppDelegate).parameters
                    var parameters = Parameters.instance.parameters
                    
                    Parameters.instance.parameters["appactive"] = json["appactive"].string
                    
                    Parameters.instance.parameters["youtube"] = json["youtube"].string
                    
                    Parameters.instance.parameters["share_url"] = json["share_url"].string
                    Parameters.instance.parameters["share_title"] = json["share_title"].string
                    Parameters.instance.parameters["share_description"] = json["share_description"].string
                    Parameters.instance.parameters["share_image"] = json["share_image"].string
                    Parameters.instance.parameters["shareresult_url"] = json["shareresult_url"].string
                    
                    Parameters.instance.parameters["page_rule"] = json["page_rule"].string
                    Parameters.instance.parameters["page_winner"] = json["page_winner"].string
                    Parameters.instance.parameters["page_howto"] = json["page_howto"].string
                    
                    print("parameters.instance: \(unsafeAddressOf(Parameters.instance))")
                    
                    for (key, value) in Parameters.instance.parameters {
                        print("getData - \(key): \(value)")
                    }
                }
        }
        
        var parameters = Dictionary<String, AnyObject>()
        
        parameters["stat"] = "estvolleyball"
        parameters["param1"] = "ios"
        parameters["param2"] = "openapp"
        
        Alamofire.request(.GET, "http://www.estcolathai.com/volleyballmobile/api/mobile/applicationstatlog.aspx", parameters: parameters)
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeController.tapGestureHandler))
        self.tapGestureView.frame = CGRectMake(0.0, 0.0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        self.tapGestureView.backgroundColor = UIColor.clearColor()
        if let tapGesture = self.tapGesture {
            self.tapGestureView.addGestureRecognizer(tapGesture)
        }
        
        if let _ = FBSDKAccessToken.currentAccessToken() {
            print("currentAccessToken != nil")
            let uid = KeychainSwift().get("uid")
            print("uid: \(uid)")
        } else {
            print("currentAccessToken == nil")
            if let uid = KeychainSwift().get("uid") where uid != "" {
            } else {
                let keychain = KeychainSwift()
                keychain.set(NSUUID().UUIDString, forKey: "uid")
            }
        }
        
        
        
        let screenSize = UIScreen.mainScreen().bounds.size
        
        self.homeBackground.layer.zPosition = 1
        self.frontText.layer.zPosition = 3
        
        if (screenSize.height == 480.0 || screenSize.height == 1024.0){
            print("iphone4s/ipad")
            self.ballView.frame = CGRectMake(100.0/320.0*screenSize.width, -71.0/480.0*screenSize.height, 403.0/320.0*screenSize.width, 399.0/480.0*screenSize.height)
        }else{
            print("iphone5,6,6plus")
            self.ballView.frame = CGRectMake(100.0/320.0*screenSize.width, -71.0/568.0*screenSize.height, 403.0/320.0*screenSize.width, 399.0/568.0*screenSize.height)
        }
        self.ballView.layer.zPosition = 2
        self.view.addSubview(self.ballView)
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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.4, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
                self.blinkButton.alpha = 0.2
            }, completion: { finished in
        })
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(goStartGame), userInfo: nil, repeats: false)
        self.view.addSubview(self.tapGestureView)
    }
    
    func goStartGame(){
        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
    }
    
    func tapGestureHandler() {
        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
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
