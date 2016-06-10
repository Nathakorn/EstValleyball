//
//  GameController.swift
//  EstValleyball
//
//  Created by KORN on 6/10/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    @IBOutlet weak var kmHr: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var spinBall: UIImageView!
    @IBOutlet weak var numCountDown: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        //number countdown
        self.numCountDown.animationImages = [
            UIImage(named:"count3.png")!,
            UIImage(named:"count2.png")!,
            UIImage(named:"count1.png")!
        ]
        self.numCountDown.animationDuration = 3
        self.numCountDown.animationRepeatCount = 1
        self.numCountDown.startAnimating()
        //ball
      
        UIView.animateWithDuration(0.2, delay: 4, options: [UIViewAnimationOptions.CurveEaseOut], animations: {
            var originFrame = self.spinBall.frame
            //let screenSize: CGRect = UIScreen.mainScreen().bounds
            self.spinBall.animationImages = [
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
            self.spinBall.animationDuration = 0.2
            //self.spinBall.animationRepeatCount = 1
            self.spinBall.startAnimating()
            
            //ZoomIn,out ball
            //originFrame = CGRectMake(0,0,0,0)
            //move ball
            //originFrame.origin.y = 450.0
            originFrame = CGRectMake(-250,-100,450,450)
            self.spinBall.frame = originFrame
            }, completion: { finished in
                var score = 0;
                UIView.animateWithDuration(100000,
                    delay: 0,
                    options: UIViewAnimationOptions.Repeat,
                    animations: {
                        for (score = 0; score <= 50; score++) {
                            self.score.text = String(score)
                        }
                    }, completion: { finished in
                        if (score == 50) {
                            self.score.layer.removeAllAnimations()
                            self.score.text = String(score)
                        }
                })
                //self.score.text = "99"
                self.kmHr.image = UIImage(named: "imv_bg_num.png")
        })
        
        
       
        
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
   
}
