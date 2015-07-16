//
//  CircleView.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit



enum LesionFirmness{
    case SOFT, MEDIUM, HARD
}

class CircleView: UIView {
    
    var  highlight:Bool?=false
    var  time:NSDate?
    var firmness:LesionFirmness?
    var size:Int?
    var point:CGPoint?
    var x:Float?
    var y:Float?
    

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSize(size:Int){
        self.size=size
    }
    
    func setFirmness(firmness:LesionFirmness){
        self.firmness=firmness
    }
    
    func setHighlight(highlight:Bool){
        self.highlight=highlight
    }
    
    func setPoint(point:CGPoint){
        self.point=point
    }
    
    
    override func drawRect(rect: CGRect) {
        // Get the Graphics Context
        var context = UIGraphicsGetCurrentContext();
        
        // Set the circle outerline-width
        CGContextSetLineWidth(context, 5.0);
        
        // Set the circle outerline-colour
        UIColor.redColor().set()
        
        // Create Circle
        CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        
        // Draw
        CGContextStrokePath(context);
    }


}
