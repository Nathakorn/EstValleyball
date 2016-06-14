//
//  ResultController.swift
//  EstValleyball
//
//  Created by KORN on 6/12/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class ResultController: UIViewController, FBSDKSharingDelegate {
    
    var data : NSData!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var facebookImg: UIImageView!
    var capView = UIView()
    var screenSize = UIScreen.mainScreen().bounds.size
    var widthMultiplier = 320 * UIScreen.mainScreen().bounds.size.width
    var heightMultiplier = 568 * UIScreen.mainScreen().bounds.size.height
    
    var profileImageView = UIImageView()

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showedMenu"){
            let destination = segue.destinationViewController as! MenuController
            destination.fromSegue = SEGUE_SHOW_RESULT
            //self.performSegueWithIdentifier(SEGUE_SHOW_MENU, sender: nil)
        }
    }
    override func viewDidAppear(animated: Bool) {
        //currentMaxVelocity = 28
        var resultView = UIView()
        resultView.frame = CGRectMake(0,0,320/320*self.screenSize.width, 524/568*self.screenSize.height)
        
        print("resultView.frame: \(resultView.frame)")
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        
        var score = UILabel()
        score.text = String(currentMaxVelocity)
        score.textColor = UIColor.whiteColor()
        score.layer.zPosition = 200
        score.font = UIFont(name: "PSLEmpireProBoldItalic", size: 45.0/568*self.screenSize.height)

        
        //rotate image
        let degrees:CGFloat = -8
        profileImageView.transform = CGAffineTransformMakeRotation(degrees * CGFloat(M_PI/180) )
        score.transform = CGAffineTransformMakeRotation(degrees * CGFloat(M_PI/180) )
        
        //resultView.backgroundColor = UIColor.blackColor()
        //noPlayPopupView.alpha = 0.3
        resultView.layer.zPosition = 5
        var result = UIImageView()
        if currentMaxVelocity > 55{
            let image = UIImage(named: "bg_result1v2.png")
            result = UIImageView(image: image)
            score.frame = CGRectMake(232/320*self.screenSize.width,
                                     260/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 132.0/320*self.screenSize.width
            y = 287.0/568*self.screenSize.height
            
        }
        else if currentMaxVelocity <= 55 && currentMaxVelocity > 45{
            let image = UIImage(named: "bg_result2v2.png")
            result = UIImageView(image: image)
            score.frame = CGRectMake(240/320*self.screenSize.width,
                                     260/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 155.0/320*self.screenSize.width
            y = 287.0/568*self.screenSize.height
        }
        else if currentMaxVelocity <= 45 && currentMaxVelocity > 40{
            let image = UIImage(named: "bg_result3v2.png")
            result = UIImageView(image: image)
            score.frame = CGRectMake(160/320*self.screenSize.width,
                                     214/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 77.0/320*self.screenSize.width
            y = 237.0/568*self.screenSize.height

        }
        else if currentMaxVelocity <= 40 && currentMaxVelocity > 30{
            let image = UIImage(named: "bg_result4v2.png")
            result = UIImageView(image: image)
            score.frame = CGRectMake(132/320*self.screenSize.width,
                                     260/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 50.0/320*self.screenSize.width
            y = 285.0/568*self.screenSize.height
        }
        else if currentMaxVelocity <= 30{
            let image = UIImage(named: "bg_result5v2.png")
            result = UIImageView(image: image)
            score.frame = CGRectMake(123/320*self.screenSize.width,
                                     235/568*self.screenSize.height,
                                     60/320*self.screenSize.width,
                                     60/568*self.screenSize.height)
            x = 40.0/320*self.screenSize.width
            y = 260.0/568*self.screenSize.height
        }
        resultView.addSubview(result)

        result.frame = CGRectMake(0,44/568*self.screenSize.height,320/320*self.screenSize.width, 524/568*self.screenSize.height)
        result.layer.zPosition = 2
        resultView.addSubview(score)
        
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
        self.view.sendSubviewToBack(resultView)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.profileImageView.frame = CGRectMake(x, y, 80.0, 55.0)
            self.profileImageView.layer.zPosition = 100
            
            var fbId = FBSDKAccessToken.currentAccessToken().userID
            let url = NSURL(string:"http://graph.facebook.com/" + fbId + "/picture?type=square")
            self.data = NSData(contentsOfURL: url!)
            if let image = UIImage(data: self.data) {
                self.profileImageView.image = image
            }
            
            self.profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
            self.profileImageView.layer.borderWidth = 1.0
            
            self.view.addSubview(self.profileImageView)
            self.view.bringSubviewToFront(self.profileImageView)
        })
       
        capView.frame = CGRectMake(0.0, 0.0, 300.0/320*self.screenSize.width, 157.5/568*self.screenSize.height)
        var sharePic = UIImageView()
        sharePic.frame = CGRectMake(0.0, 0.0, 300.0/320*self.screenSize.width, 157.5/568*self.screenSize.height)
        if currentMaxVelocity > 55{
            sharePic.image = UIImage(named: "share1.png")
        }
        else if currentMaxVelocity <= 55 && currentMaxVelocity > 45{
            sharePic.image = UIImage(named: "share2.png")
        }
        else if currentMaxVelocity <= 45 && currentMaxVelocity > 40{
            sharePic.image = UIImage(named: "share3.png")
        }
        else if currentMaxVelocity <= 40 && currentMaxVelocity > 30{
            sharePic.image = UIImage(named: "share4.png")
        }
        else if currentMaxVelocity <= 30{
            sharePic.image = UIImage(named: "share5.png")
        }
        capView.addSubview(sharePic)
        //capView.
        
        
        
        //score.format = "%d"
        score.text = String(currentMaxVelocity)
        //print(FBSDKAccessToken.currentAccessToken().userID)
        
        // facebookImg.image = UIImage(data:data!)
    }
    func goStartNewGame(sender: UIButton){
        self.performSegueWithIdentifier(SEGUE_STARTED_GAME, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FBSDKAccessToken.currentAccessToken().userID)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
