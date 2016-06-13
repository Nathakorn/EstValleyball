//
//  ResultController.swift
//  EstValleyball
//
//  Created by KORN on 6/12/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class ResultController: UIViewController, FBSDKSharingDelegate {
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showedMenu"){
            let destination = segue.destinationViewController as! MenuController
            destination.fromSegue = SEGUE_SHOW_RESULT
            //self.performSegueWithIdentifier(SEGUE_SHOW_MENU, sender: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
