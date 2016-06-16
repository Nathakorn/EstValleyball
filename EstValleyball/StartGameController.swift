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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showedMenu"){
            let destination = segue.destinationViewController as! MenuController
            destination.fromSegue = SEGUE_STARTED_GAME
            //self.performSegueWithIdentifier(SEGUE_SHOW_MENU, sender: nil)
        }
    }
    /*
    @IBAction func goMenu(sender: UIButton) {
        self.performSegueWithIdentifier(SEGUE_SHOW_MENU, sender: nil)
    }*/
    
    @IBOutlet weak var keepBall: UIImageView!
    var isImageBottom = true
    func startGame() {
        self.performSegueWithIdentifier(SEGUE_STARTED_GAME, sender: nil)
    }
    
    /*
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        Alamofire.request(.GET, "http://www.estcolathai.com/volleyballmobile/api/mobile/getDataInfo.aspx")
            .validate()
            .responseJSON { response in
                debugPrint(response)
                let respons = response as! NSDictionary
                let result = respons.objectForKey("winner")! as! String
                print(result)
        }*/
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
    override func viewDidAppear(animated: Bool) {
        
        //var customFrame = keepBall.frame
        //bright start button
        UIView.animateWithDuration(0.4, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
            self.blinkButton.alpha = 0.2
            }, completion: { finished in
        })
        
        let screenSize = UIScreen.mainScreen().bounds.size
        
        var keepBall = UIImageView()
        let image = UIImage(named: "hand.png")
        keepBall = UIImageView(image: image)
        keepBall.frame = CGRectMake(0, 240/568*screenSize.height, screenSize.width,390/568*screenSize.height)
        keepBall.layer.zPosition = 4
        self.view.addSubview(keepBall)
        UIView.animateWithDuration(0.8, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
                var originFrame = keepBall.frame
                originFrame.origin.y = 222.0/568.0*screenSize.height
                keepBall.frame = originFrame
            }, completion: { finished in
        })
        /*
        self.startButton.imageView?.animationImages = [
            UIImage(named:"img_light.png")!,
            UIImage(named:"11.png")!
        ]
        self.startButton.imageView?.animationDuration = 1
        self.startButton.imageView?.animationRepeatCount = 3
        self.startButton.imageView?.startAnimating()
        */
        /*
        UIView.animateWithDuration(1.0,
            animations: {
         
            }, completion: { finished in
                
        })
        */
        //keepBall.frame = customFrame
        //keepBall.image = UIImage(named: "07" )
        //isImageLeftSide = !isImageLeftSide
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
