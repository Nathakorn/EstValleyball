//
//  StartGameController.swift
//  EstValleyball
//
//  Created by KORN on 6/9/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit
import Alamofire

class StartGameController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var brightStart: UIImageView!
    
    var normalButton = UIImageView()
    var blinkButton = UIImageView()
    var start = UIButton()
    var winner = NSInteger()
    var popupView = UIView()
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showedMenu"){
            let destination = segue.destinationViewController as! MenuController
            destination.fromSegue = SEGUE_STARTED_GAME
        }
    }
    var isImageBottom = true
    
    func startGame() {
        self.performSegueWithIdentifier(SEGUE_STARTED_GAME, sender: nil)
        
        var parameters = Dictionary<String, AnyObject>()
        
        parameters["stat"] = "estvolleyball"
        parameters["param1"] = "ios"
        parameters["param2"] = "startgame"
        
        Alamofire.request(.GET, "http://www.estcolathai.com/volleyballmobile/api/mobile/applicationstatlog.aspx", parameters: parameters)
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Button, action: .Clicked, label: "start")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EstValleyballHTTPService.instance.sendGoogleAnalyticsEventTracking(.Page, action: .Opened, label: "Start Game Page")
        
        let screenSize = UIScreen.mainScreen().bounds.size
        let buttonRect = CGRectMake(83.0/320.0*screenSize.width, 213.0/568.0*screenSize.height, 148.0/320.0*screenSize.width, 79.0/568.0*screenSize.height)
        
        self.normalButton.frame = buttonRect
        self.blinkButton.frame = buttonRect
        
        self.normalButton.image = UIImage(named: "btn_start_a")
        self.blinkButton.image = UIImage(named: "btn_start_b")
        
        self.start.frame = buttonRect
        self.start.addTarget(self, action: #selector(StartGameController.startGame), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.normalButton)
        self.view.addSubview(self.blinkButton)
        self.view.addSubview(self.start)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let screenSize = UIScreen.mainScreen().bounds.size
        //blink button
        UIView.animateWithDuration(0.4, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
            self.blinkButton.alpha = 0.2
            }, completion: { finished in
        })
        //hand keep ball
        var keepBall = UIImageView()
        let image = UIImage(named: "hand.png")
        keepBall = UIImageView(image: image)
        keepBall.frame = CGRectMake(0, 240/568*screenSize.height, screenSize.width,390/568*screenSize.height)
        keepBall.layer.zPosition = 0
        self.view.addSubview(keepBall)
        UIView.animateWithDuration(0.8, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
                var originFrame = keepBall.frame
                originFrame.origin.y = 222.0/568.0*screenSize.height
                keepBall.frame = originFrame
            }, completion: { finished in
        })
        //finish campaign popupView
        //var popupView = UIView()
        popupView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
        //dim background
        var dimBackground = UIImageView()
        dimBackground.frame = CGRectMake(0,0,screenSize.width, screenSize.height)
        dimBackground.backgroundColor = UIColor.blackColor()
        dimBackground.alpha = 0.6
        dimBackground.layer.zPosition = 4
        //add dim background
        popupView.addSubview(dimBackground)
        //add finish campaign image
        var finishCamView = UIImageView()
        let finishCamImage = UIImage(named: "bg_finish_campaign.png")
        finishCamView  = UIImageView(image: finishCamImage)
        finishCamView.frame = CGRectMake(0, 52/568*screenSize.height,320/320*screenSize.width,295/568*screenSize.height)
        finishCamView.layer.zPosition = 5
        //add finish campaign view
        popupView.addSubview(finishCamView)
        //close button
        let goBackButton = UIButton()
        goBackButton.frame = CGRectMake(270/320*screenSize.width,115/568*screenSize.height,20/320*screenSize.width,20/568*screenSize.height)
        goBackButton.setImage(UIImage(named: "btn_close_tvc"), forState: .Normal)
        goBackButton.layer.zPosition = 8
        goBackButton.addTarget(self, action: #selector(closePopup), forControlEvents: .TouchUpInside)
        //add back button
        popupView.addSubview(goBackButton)
        //add to main view
        self.view.addSubview(popupView)
        
        
        
    }
    func closePopup(){
        popupView.alpha = 0
    }
    override func viewDidAppear(animated: Bool) {
        // Do any additional setup after loading the view.
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
