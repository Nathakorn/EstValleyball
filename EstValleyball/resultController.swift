//
//  ResultController.swift
//  EstValleyball
//
//  Created by KORN on 6/12/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class ResultController: UIViewController, FBSDKSharingDelegate {
   
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    var data : NSData!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var facebookImg: UIImageView!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showedMenu"){
            let destination = segue.destinationViewController as! MenuController
            destination.fromSegue = SEGUE_SHOW_RESULT
            //self.performSegueWithIdentifier(SEGUE_SHOW_MENU, sender: nil)
        }
    }
    override func viewDidAppear(animated: Bool) {
        shareButton.layer.zPosition = 11
        newGameButton.layer.zPosition = 12
        var resultView = UIView()
        resultView.frame = CGRectMake(0,0,320, 524)
        //resultView.backgroundColor = UIColor.blackColor()
        //noPlayPopupView.alpha = 0.3
        resultView.layer.zPosition = 5
        var result = UIImageView()
        if currentMaxVelocity > 55{
            let image = UIImage(named: "bg_result1.png")
            result = UIImageView(image: image)
        }
        else if currentMaxVelocity <= 55 && currentMaxVelocity > 45{
            let image = UIImage(named: "bg_result2.png")
            result = UIImageView(image: image)
            
        }
        else if currentMaxVelocity <= 45 && currentMaxVelocity > 40{
            let image = UIImage(named: "bg_result3.png")
            result = UIImageView(image: image)
        }
        else if currentMaxVelocity <= 40 && currentMaxVelocity > 30{
            let image = UIImage(named: "bg_result4.png")
            result = UIImageView(image: image)
        }
        else if currentMaxVelocity <= 30{
            let image = UIImage(named: "bg_result5.png")
            result = UIImageView(image: image)
        }
        result.frame = CGRectMake(0,44,320, 524)
        result.layer.zPosition = 2
        resultView.addSubview(result)
        self.view.addSubview(resultView)
        //score.format = "%d"
        score.text = String(currentMaxVelocity)
        //print(FBSDKAccessToken.currentAccessToken().userID)
        
        facebookImg.image = UIImage(data:data!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FBSDKAccessToken.currentAccessToken().userID)
        // Do any additional setup after loading the view.
        var fbId = FBSDKAccessToken.currentAccessToken().userID
        let url = NSURL(string:"http://graph.facebook.com/" + fbId + "/picture?type=square")
        data = NSData(contentsOfURL:url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbShareResult(sender: AnyObject) {
        var resultImage = UIImageView(frame: CGRectMake(0.0, 0.0, 200.0, 200.0))
        resultImage.image = UIImage(named: "14.png")
        
        var button = UIImageView(frame: CGRectMake(50.0, 50.0, 50.0, 50.0))
        button.image = UIImage(named: "V_Spin_00000.png")
        button.contentMode = UIViewContentMode.ScaleAspectFit
        
        resultImage.addSubview(button)
        
        UIGraphicsBeginImageContextWithOptions(resultImage.frame.size, true, UIScreen.mainScreen().scale)
        var ctx: CGContextRef = UIGraphicsGetCurrentContext()!
        resultImage.layer.renderInContext(ctx)
        var shareImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        var photo = FBSDKSharePhoto()
        photo.image = shareImage
        photo.userGenerated = true
        var photoContent = FBSDKSharePhotoContent()
        
        photoContent.photos = [photo]
        FBSDKShareDialog.showFromViewController(self, withContent: photoContent, delegate: self)
        
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
        print("didFailWithError")
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
