//
//  BaseBrush.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import CoreGraphics

protocol PaintBrush {
    
    func supportedContinuousDrawing() -> Bool;
    
    func drawInContext(context: CGContextRef)
}

class BaseBrush: NSObject , PaintBrush{
    
    var beginPoint: CGPoint!
    var endPoint: CGPoint!
    var lastPoint: CGPoint?
    
    var strokeWidth: CGFloat!
    
    func supportedContinuousDrawing() -> Bool {
        return false
    }
    
    func drawInContext(context: CGContextRef) {
        assert(false, "must implements in subclass.")
    }
   
}
