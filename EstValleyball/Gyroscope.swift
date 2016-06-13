//
//  ViewController.swift
//  GyroTest
//
//  Created by KORN on 6/7/2559 BE.
//  Copyright © 2559 Nathakorn Sukumsirichart. All rights reserved.
//

import UIKit
import CoreMotion

    
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
            currentMaxVelocity = Int(floor(velocity * 2.5))
            if(currentMaxVelocity > 25){
                lightBling.stopAnimating()
                UIView.animateWithDuration(0.2, animations: {
                    var originFrame = comingBall.frame
                    if isHit == false{
                        let randomOneTwo = Int(arc4random_uniform(2) + 1)
                        if randomOneTwo == 1{
                            originFrame = CGRectMake(screenSize.width/2-100, 340, 0, 0)
                            isHit = true
                            //game.afterHitBall()
                            NSTimer.scheduledTimerWithTimeInterval(1, target: game, selector: #selector(GameController.afterHitBall), userInfo: nil, repeats: false)
                        }
                        else{
                            originFrame = CGRectMake(screenSize.width/2+100, 340, 0, 0)
                            isHit = true
                            //game.afterHitBall()
                            NSTimer.scheduledTimerWithTimeInterval(1, target: game, selector: #selector(GameController.afterHitBall), userInfo: nil, repeats: false)
                        }
                    }
                    comingBall.frame = originFrame
                    
                    }, completion: { finished in
                       
                })
            }
            if i == 300 {
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



