//
//  ViewController.swift
//  GyroTest
//
//  Created by KORN on 6/7/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox
import AVFoundation

var motionManager = CMMotionManager()
var currentMaxAccelX = 0.0
var currentMaxAccelY = 0.0
var currentMaxAccelZ = 0.0
var currentMaxVelocity = 0

let screenSize: CGRect = UIScreen.mainScreen().bounds
func startPitch(comingBall : UIImageView, lightBling: UIImageView, game: GameController){
    //for count time
    var i = 0
    var isHit = false
    var isVibration = false
    motionManager.accelerometerUpdateInterval = 0.01
    motionManager.gyroUpdateInterval = 0.01
    resetMaxValues()
    //start recording data
    let _:CMAccelerometerData!
    let _:NSError!
    motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: {
        accelerometerData,error in
        i += 1
        let accX = outputAccelerationDataX(accelerometerData!.acceleration)
        let accY = outputAccelerationDataX(accelerometerData!.acceleration)
        let accZ = outputAccelerationDataX(accelerometerData!.acceleration)
        //calcurate km/hr
        //var vX = accX * pow(motionManager.accelerometerUpdateInterval,2)
        let velocity = sqrt(pow(accX,2) * 3 + pow(accY,2) * 3 + pow(accZ,2) * 3)
        //var velocitykh = velocity
        //print(Int(floor(velocity)))
        currentMaxVelocity = Int(floor(velocity * 2.5 * 1.42))
        let randomOneToThree = Int(arc4random_uniform(4) + 1)
        currentMaxVelocity += randomOneToThree
        if(currentMaxVelocity >= 50){
            if isVibration == false{
                NSTimer.scheduledTimerWithTimeInterval(0, target: game, selector: #selector(GameController.playHitSound), userInfo: nil, repeats: false)
            }
            lightBling.stopAnimating()
            UIView.animateWithDuration(0.5, delay: 0, options: [UIViewAnimationOptions.TransitionNone],animations: {
                if isVibration == false{
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    isVibration = true
                }
                var originFrame = comingBall.frame
                if isHit == false{
                    let randomOneTwo = Int(arc4random_uniform(2) + 1)
                    if randomOneTwo == 1{
                        originFrame = CGRectMake(screenSize.width/2-100/320 * screenSize.width
                            ,290/568 * screenSize.height
                            ,25/320 * screenSize.width
                            ,25/568 * screenSize.height)
                        isHit = true
                        //game.afterHitBall()
                        NSTimer.scheduledTimerWithTimeInterval(0.4, target: game, selector: #selector(GameController.hitBallTwo), userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1, target: game, selector: #selector(GameController.afterHitBall), userInfo: nil, repeats: false)
                    }
                    else{
                        originFrame = CGRectMake(screenSize.width/2+100/320 * screenSize.width
                            ,290/568 * screenSize.height
                            ,25/320 * screenSize.width
                            ,25/568 * screenSize.height)
                        isHit = true
                        //game.afterHitBall()
                        NSTimer.scheduledTimerWithTimeInterval(0.4, target: game, selector: #selector(GameController.hitBallTwo), userInfo: nil, repeats: false)
                        NSTimer.scheduledTimerWithTimeInterval(1, target: game, selector: #selector(GameController.afterHitBall), userInfo: nil, repeats: false)
                    }
                }
                comingBall.frame = originFrame
                
                }, completion: { finished in
                    /*
                     if isHit == true && isHitTwo == false{
                     print("test")
                     UIView.animateWithDuration(0.2, animations: {
                     var originFrame2 = comingBall.frame
                     originFrame2 = CGRectMake(screenSize.width/2, 300, 0, 0)
                     comingBall.frame = originFrame2
                     isHitTwo = true
                     }, completion: { finished in
                     })
                     }
                     */
            })
        }
        if i == 300 && isHit == false{
            print("no play")
            motionManager.stopAccelerometerUpdates()
            game.showNoplay()
        }
        print(currentMaxVelocity)
    })
    
}

func resetMaxValues() {
    currentMaxAccelX = 0
    currentMaxAccelY = 0
    currentMaxAccelZ = 0
}

func outputAccelerationDataX(acceleration: CMAcceleration) -> Double{
    if fabs(acceleration.x) > fabs(currentMaxAccelX){
        currentMaxAccelX = acceleration.x
    }
    return currentMaxAccelX
}
func outputAccelerationY(acceleration: CMAcceleration) -> Double{
    if fabs(acceleration.y) > fabs(currentMaxAccelY){
        currentMaxAccelY = acceleration.y
    }
    return currentMaxAccelY
}
func outputAccelerationDataZ(acceleration: CMAcceleration) -> Double{
    if fabs(acceleration.z) > fabs(currentMaxAccelZ){
        currentMaxAccelZ = acceleration.z
    }
    return currentMaxAccelZ
    

}



