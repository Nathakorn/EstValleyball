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

    func startPitch(){
        motionManager.accelerometerUpdateInterval = 0.05
        motionManager.gyroUpdateInterval = 0.05
        resetMaxValues()
        //start recording data
        let _:CMAccelerometerData!
        let _:NSError!
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: {
            accelerometerData,error in
            let accX = outputAccelerationDataX(accelerometerData!.acceleration)
            let accY = outputAccelerationDataX(accelerometerData!.acceleration)
            let accZ = outputAccelerationDataX(accelerometerData!.acceleration)
            //calcurate km/hr
            //var vX = accX * pow(motionManager.accelerometerUpdateInterval,2)
            let velocity = sqrt(pow(accX,2) * 3 + pow(accY,2) * 3 + pow(accZ,2) * 3)
            //var velocitykh = velocity
            //print(Int(floor(velocity)))
            currentMaxVelocity = Int(floor(velocity * 2.5))
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



