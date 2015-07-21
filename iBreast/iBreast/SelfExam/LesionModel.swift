//
//  LesionModel.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/18.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class LesionModel: NSObject {
   
    
    var  highlight:Bool! = false
    var  time:NSDate! = NSDate()
    var firmness:LesionFirmness! = LesionFirmness.HARD
    var size:CGFloat! = 0
    var point:CGPoint! = CGPoint(x: 0, y: 0)
    var x:Float! = 0
    var y:Float! = 0
    var allowedMoving:Bool! = false
    
}
