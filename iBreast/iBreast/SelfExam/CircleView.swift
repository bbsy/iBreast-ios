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

class LesionView: UIView {

    var scaleToSize:CGSize!
    var highLightImage:UIImage?
    var origImage:UIImage?
    //是否第一次增加
    var firtlyAdd = false
    
    var lesion: LesionModel = LesionModel()
    
    var  context:CGContext?

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        scaleToSize = CGSize(width: frame.size.width,height: frame.size.height)
    }
    
   
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSize(size:CGFloat){
        lesion.size=size
    }
    
    func setFirmness(firmness:Int){
        lesion.firmness=firmness
    }
    
    func setHighlight(highlight:Bool){
        lesion.highlight=highlight
    }
    
    func setPoint(point:CGPoint){
        lesion.point=point
    }
    
    func setHighLight(high:Bool){
        lesion.highlight = high
        if(high == true){
            if origImage == nil{
                if(firtlyAdd == true){
                    
                }
                else{
                     origImage = UIImage(named: "0")!;
                   
                }
            }
          
                 NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "zoomImage:", userInfo: nil, repeats: true)
            
           
            

        }
        
    }
    
    func zoomImage(sender:AnyObject?){
    
        if(scaleToSize.width < frame.size.width){
            
            scaleToSize.width = frame.size.width
            scaleToSize.height = scaleToSize.width
        }
        else{
            
            scaleToSize.width = frame.size.width - 20
            scaleToSize.height = frame.size.height - 20
        }
        
        setNeedsDisplay()
        if( origImage != nil && context != nil){
            
//            
//            CGContextSetShadow(context, CGSizeMake(3, 3),10)
//            
//            // 创建一个bitmap的context
//            // 并把它设置成为当前正在使用的context
//            UIGraphicsBeginImageContext(frame.size);
//            
//            // 绘制改变大小的图片
//            origImage!.drawInRect(CGRectMake(0, 0, scaleToSize.width, scaleToSize.height))
//            
//            // 从当前context中创建一个改变大小后的图片
//            highLightImage = UIGraphicsGetImageFromCurrentImageContext();
//            
//            // 使当前的context出堆栈
//            UIGraphicsEndImageContext();
//            
//            highLightImage!.drawAtPoint(CGPointMake(0, 0));
            
        }

    }
    
    
    override func drawRect(rect: CGRect) {
        // Get the Graphics Context
        context = UIGraphicsGetCurrentContext();
        
        CGContextSetAllowsAntialiasing(context, true) //抗锯齿设置
        
        // Set the circle outerline-width
        CGContextSetLineWidth(context, 5.0);
        
        // Set the circle outerline-colour
        if(lesion.didAdd == true){
            UIColor.yellowColor().set()
        }
        else if(lesion.didDelete == true){
            UIColor.redColor().set()
        }
        else {
           // UIColor.grayColor().set()
        }
        
        
        
        
        
        if( origImage != nil){
            
            
            CGContextSetShadow(context, CGSizeMake(3, 3),10)
            
            // 创建一个bitmap的context
            // 并把它设置成为当前正在使用的context
            UIGraphicsBeginImageContext(frame.size);
            
            // 绘制改变大小的图片
            origImage!.drawInRect(CGRectMake(0, 0, scaleToSize.width, scaleToSize.height))
            
            // 从当前context中创建一个改变大小后的图片
            highLightImage = UIGraphicsGetImageFromCurrentImageContext();
            
            // 使当前的context出堆栈
            UIGraphicsEndImageContext();
            
            highLightImage!.drawAtPoint(CGPointMake((frame.size.width - scaleToSize.width)/2 ,(frame.size.height - scaleToSize.height)/2));

        }
        
        
        // Create Circle
        CGContextAddArc(context, (frame.size.width)/2, (frame.size.height)/2, (frame.size.width-15)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        // Draw
        CGContextStrokePath(context);
        
        
       
    }


}
