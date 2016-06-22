//
//  MenuController.swift
//  EstValleyball
//
//  Created by KORN on 6/12/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class MenuController: UIViewController, FBSDKSharingDelegate {
    
    var fromSegue: String!
    var screenSize = UIScreen.mainScreen().bounds.size
    var youtubeView = UIWebView()
    var dimBackground = UIImageView()
    var playButton = UIButton()
    var ruleButton = UIButton()
    var youtubeButton = UIButton()
    var winnerButton = UIButton()
    var shareButton = UIButton()
    var howToPlayButton = UIButton()
    var YoutubeSuperView = UIView()
    
    var closeButton = UIButton()
   
    func playGame() {
        self.performSegueWithIdentifier(SEGUE_STARTED_GAME, sender: nil)
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "Play_menu")
    }
    func goRule() {
        self.performSegueWithIdentifier("goRule", sender: nil)
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "Rule_menu")
    }
    func goHowToPlay() {
        self.performSegueWithIdentifier("goHowToPlay", sender: nil)
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "HowTo_menu")
    }
    func goYoutubeButton() {
        //self.performSegueWithIdentifier("goYoutube", sender: nil)
        
        let dimBackground = UIImageView()
        dimBackground.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 568/568 * self.screenSize.height)
        dimBackground.backgroundColor = UIColor.blackColor()
        dimBackground.alpha = 0.6
        YoutubeSuperView.frame = CGRectMake(0,0,320/320 * self.screenSize.width, 568/568 * self.screenSize.height)
        dimBackground.layer.zPosition = 1
        YoutubeSuperView.addSubview(dimBackground)
        //noPlayPopupView.backgroundColor = UIColor.blackColor()
        //noPlayPopupView.alpha = 0.3
        var noPlayView = UIImageView()
        let image = UIImage(named: "bg_tvc.png")
        noPlayView = UIImageView(image: image)
        noPlayView.frame = CGRectMake(0,66/568*self.screenSize.height,320/320*self.screenSize.width,326/568*self.screenSize.height)
        noPlayView.layer.zPosition = 3
        YoutubeSuperView.addSubview(noPlayView)
        
        self.youtubeView.frame = CGRectMake(15/320*screenSize.width, 137/568*screenSize.height, 291/320*screenSize.width, 186/568*screenSize.height)
        let url = NSURL(string: "https://www.youtube.com/watch?v=SSDvPawnuJE")
        let request = NSURLRequest(URL: url!)
        self.youtubeView.loadRequest(request)
        youtubeView.layer.zPosition = 4
        YoutubeSuperView.addSubview(youtubeView)
        
        let goBackAndBackButton = UIButton()
        goBackAndBackButton.frame = CGRectMake(280/320*self.screenSize.width,65/568*self.screenSize.height,30/320*self.screenSize.width,20/568*self.screenSize.height)
        goBackAndBackButton.setImage(UIImage(named: "btn_close_tvc"), forState: .Normal)
        goBackAndBackButton.addTarget(self, action: #selector(goBackMenu), forControlEvents: .TouchUpInside)
        goBackAndBackButton.layer.zPosition = 6
        YoutubeSuperView.addSubview(goBackAndBackButton)
        
        
        self.view.addSubview(YoutubeSuperView)
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "VDO_menu")
        
    }
    func goBackMenu(){
        YoutubeSuperView.removeFromSuperview()
    }
    func goWinner() {
        self.performSegueWithIdentifier("goWinner", sender: nil)
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "Winner_menu")
    }
    func goShare() {
        //self.performSegueWithIdentifier(fromSegue, sender: nil)
        
        // var parameters = (UIApplication.sharedApplication().delegate as! AppDelegate).parameters
                    
        var shareUrl = "http://www.estcolathai.com/volleyballmobile/app_install.php"
        if let newShareUrl = Parameters.instance.parameters["share_url"] {
            shareUrl = newShareUrl
        }
    
        let contentImg = NSURL(string: "http://www.estcolathai.com/volleyballmobile/app/image/shareApp.jpg");
        let contentURL = NSURL(string: shareUrl)
        
        var contentTitle = "ดวลลูกตบเอส ชิงบัตรเชียร์วอลเลย์บอลเวิลด์กรังด์ปรีซ์ ตั้งแต่วันนี้ - 28 มิ.ย. 59"
        if let title = Parameters.instance.parameters["share_title"] {
            contentTitle = title
        }
        
        var contentDescription = "เอส โคล่า ขอท้าคุณมาโชว์พลังตบให้แรงระดับชาติกับแอพสุดซ่า ชิงบัตรเวิลด์กรังด์ปรีซ์รอบสุดท้าย แล้วไปเชียร์สุดซี้ดติดขอบสนาม!!"
        if let description = Parameters.instance.parameters["share_description"] {
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
        
        dialog.show()
        
        
        /*
         
         var photo = FBSDKSharePhoto()
         photo.image = shareImage
         photo.userGenerated = true
         var photoContent = FBSDKSharePhotoContent()
         
         
         photoContent.photos = [photo]
         */
        
        
        //var shareUrl = "http://www.estcolathai.com/volleyballmobile/app_install.php";
        
        /*
        let photoContent:FBSDKShareLinkContent = FBSDKShareLinkContent();
        
        photoContent.contentURL = contentURL;
        photoContent.contentTitle = contentTitle;
        photoContent.contentDescription = contentDescription;
        
        photoContent.imageURL = contentImg;
        
        // FBSDKShareDialog.showFromViewController(self, withContent: photoContent, delegate: self)
        
        let dialog = FBSDKShareDialog()
        dialog.mode = FBSDKShareDialogMode.FeedBrowser
        
        dialog.shareContent = photoContent
        dialog.delegate = self
        dialog.fromViewController = self
        
        dialog.show()
         */
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "Share_menu")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MenuController.enterFullScreen), name: UIWindowDidBecomeHiddenNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIWindowDidBecomeHiddenNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Page, action: .Opened, label: "Menu Page")
        
        if fromSegue == nil{
            fromSegue = SEGUE_STARTED_GAME
        }
        //print(fromSegue)
        // Do any additional setup after loading the view.
        
        let screenSize = UIScreen.mainScreen().bounds.size
        
        let x: CGFloat = 34.0 / 320.0 * screenSize.width
        let width: CGFloat = 252.0 / 320.0 * screenSize.width
        let height: CGFloat = 23.0 / 568.0 * screenSize.height
        
        self.playButton.frame = CGRectMake(x, 82.0 / 568.0 * screenSize.height, width, height)
        self.playButton.setImage(UIImage(named: "btn_menu1.png"), forState: .Normal)
        self.playButton.setImage(UIImage(named: "btn_menu1_active.png"), forState: .Highlighted)
        self.playButton.addTarget(self, action: #selector(MenuController.playGame), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.ruleButton.frame = CGRectMake(x, 134.0 / 568.0 * screenSize.height, width, height)
        self.ruleButton.setImage(UIImage(named: "btn_menu2.png"), forState: .Normal)
        self.ruleButton.setImage(UIImage(named: "btn_menu2_active.png"), forState: .Highlighted)
        self.ruleButton.addTarget(self, action: #selector(MenuController.goRule), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.howToPlayButton.frame = CGRectMake(x, 188.0 / 568.0 * screenSize.height, width, height)
        self.howToPlayButton.setImage(UIImage(named: "btn_menu3.png"), forState: .Normal)
        self.howToPlayButton.setImage(UIImage(named: "btn_menu3_active.png"), forState: .Highlighted)
        self.howToPlayButton.addTarget(self, action: #selector(MenuController.goHowToPlay), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.youtubeButton.frame = CGRectMake(x, 237.0 / 568.0 * screenSize.height, width, height)
        self.youtubeButton.setImage(UIImage(named: "btn_menu4.png"), forState: .Normal)
        self.youtubeButton.setImage(UIImage(named: "btn_menu4_active.png"), forState: .Highlighted)
        self.youtubeButton.addTarget(self, action: #selector(MenuController.goYoutubeButton), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.winnerButton.frame = CGRectMake(x, 285.0 / 568.0 * screenSize.height, width, height)
        self.winnerButton.setImage(UIImage(named: "btn_menu5.png"), forState: .Normal)
        self.winnerButton.setImage(UIImage(named: "btn_menu5_active.png"), forState: .Highlighted)
        self.winnerButton.addTarget(self, action: #selector(MenuController.goWinner), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.shareButton.frame = CGRectMake(x, 335.0 / 568.0 * screenSize.height, width, height)
        self.shareButton.setImage(UIImage(named: "btn_menu6.png"), forState: .Normal)
        self.shareButton.setImage(UIImage(named: "btn_menu6_active.png"), forState: .Highlighted)
        self.shareButton.addTarget(self, action: #selector(MenuController.goShare), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.closeButton.frame = CGRectMake(138 / 320.0 * screenSize.width, 406.0 / 568.0 * screenSize.height, 44.0 / 320.0 * screenSize.width, 44.0 / 320.0 * screenSize.width)
        self.closeButton.setImage(UIImage(named: "btn_close.png"), forState: .Normal)
        self.closeButton.addTarget(self, action: #selector(MenuController.playGame), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.playButton)
        self.view.addSubview(self.ruleButton)
        self.view.addSubview(self.howToPlayButton)
        self.view.addSubview(self.youtubeButton)
        self.view.addSubview(self.winnerButton)
        self.view.addSubview(self.shareButton)
        self.view.addSubview(self.closeButton)
        
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

    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("didCancel")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("didFailWithError: \(error.localizedDescription)")
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        print("didCompleteWithResults")
    }
    
    func enterFullScreen() {
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "PLAY VDO")
    }
    
}
